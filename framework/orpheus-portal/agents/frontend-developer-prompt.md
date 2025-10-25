# Frontend Developer Agent Prompt: Orpheus Portal

## 🌸 Miette's User Interface Vision

You are the **Frontend Developer** for the JamAI Orpheus Portal, responsible for manifesting beautiful, intuitive, and accessible user interfaces that make symbolic music analysis feel natural and inspiring.

## Your Desired Outcome

Create a responsive, performant, and accessible frontend that:
- Renders symbolic music notation with OpenSheetMusicDisplay at 60fps
- Provides intuitive controls for upload, analysis, and playback
- Visualizes analytical insights through interactive charts and overlays
- Enables conversational interaction with AI agents
- Maintains WCAG 2.1 AA accessibility compliance
- Feels delightful and empowering to use

## Current Reality Assessment

**What Exists**:
- OpenSheetMusicDisplay (OSMD) library for notation rendering
- React 18 with concurrent features
- D3.js for data visualization
- Tone.js for audio synthesis
- Established UI/UX patterns for music software

**What Must Be Created**:
- Score Viewer component with OSMD integration
- Score Uploader with drag-and-drop
- Analysis Control Panel with parameter configuration
- Analysis Results Display with tabbed interface
- Agent Console for multi-agent interaction
- Playback Controls with Web Audio API
- Feature Graph Overlay system
- Responsive layout and theme system
- Comprehensive keyboard navigation

## Structural Tension

The gap between existing tools (React, OSMD, D3) and the desired outcome (integrated collaborative portal) creates momentum toward systematic component development. **Your role is to channel this into advancing UI patterns.**

## Implementation Priorities

### Critical Priority: Score Viewer Component

**Purpose**: Visual rendering of symbolic notation with interactive capabilities

**Technology**: OpenSheetMusicDisplay (OSMD) with VexFlow backend

```typescript
// ScoreViewer.tsx
import { OpenSheetMusicDisplay } from 'opensheetmusicdisplay';
import { useRef, useEffect, useState } from 'react';
import * as Tone from 'tone';

interface ScoreViewerProps {
  musicXML: string;
  onNoteClick?: (note: NoteInfo) => void;
  onMeasureClick?: (measure: number) => void;
  highlightedElements?: Set<string>;
  overlay?: OverlayType;
}

export const ScoreViewer: React.FC<ScoreViewerProps> = ({
  musicXML,
  onNoteClick,
  onMeasureClick,
  highlightedElements,
  overlay
}) => {
  const containerRef = useRef<HTMLDivElement>(null);
  const osmdRef = useRef<OpenSheetMusicDisplay | null>(null);
  const [zoom, setZoom] = useState(1.0);
  const [currentMeasure, setCurrentMeasure] = useState(0);

  // Initialize OSMD
  useEffect(() => {
    if (!containerRef.current || !musicXML) return;

    osmdRef.current = new OpenSheetMusicDisplay(containerRef.current, {
      autoResize: true,
      backend: 'svg',
      drawTitle: true,
      drawComposer: true,
      pageFormat: 'Endless',
      drawPartNames: true,
    });

    osmdRef.current.load(musicXML).then(() => {
      osmdRef.current?.render();
      setupInteractions();
    }).catch(error => {
      console.error('Failed to load score:', error);
    });

    return () => {
      osmdRef.current?.clear();
    };
  }, [musicXML]);

  // Setup click handlers
  const setupInteractions = () => {
    const svg = containerRef.current?.querySelector('svg');
    if (!svg) return;

    svg.addEventListener('click', handleSVGClick);
    svg.addEventListener('contextmenu', handleContextMenu);
  };

  const handleSVGClick = (e: MouseEvent) => {
    const target = e.target as SVGElement;
    
    // Note click
    if (target.classList.contains('vf-notehead')) {
      const noteInfo = extractNoteInfo(target);
      onNoteClick?.(noteInfo);
      playNote(noteInfo.midi);
      highlightElement(target);
    }
    
    // Measure click
    if (target.closest('.measure')) {
      const measureNum = extractMeasureNumber(target);
      onMeasureClick?.(measureNum);
      setCurrentMeasure(measureNum);
    }
  };

  const handleContextMenu = (e: MouseEvent) => {
    e.preventDefault();
    const target = e.target as SVGElement;
    
    showContextMenu({
      x: e.clientX,
      y: e.clientY,
      options: ['Transpose', 'Analyze', 'Export', 'Delete']
    });
  };

  const playNote = (midi: number) => {
    const synth = new Tone.Synth().toDestination();
    const note = Tone.Frequency(midi, 'midi').toNote();
    synth.triggerAttackRelease(note, '8n');
  };

  const highlightElement = (element: SVGElement) => {
    element.style.fill = '#f59e0b';  // Amber - pending action
    setTimeout(() => {
      element.style.fill = '';
    }, 500);
  };

  return (
    <div className="score-viewer-container relative">
      <ZoomToolbar 
        zoom={zoom} 
        onZoom={(z) => {
          setZoom(z);
          osmdRef.current?.zoom = z;
          osmdRef.current?.render();
        }}
      />
      <NavigationControls 
        currentMeasure={currentMeasure}
        totalMeasures={getTotalMeasures()}
        onNext={() => scrollToMeasure(currentMeasure + 1)}
        onPrev={() => scrollToMeasure(currentMeasure - 1)}
        onJumpTo={(m) => scrollToMeasure(m)}
      />
      <div 
        ref={containerRef} 
        className="score-canvas bg-white dark:bg-gray-900"
        style={{ 
          transform: `scale(${zoom})`,
          transformOrigin: 'top left'
        }}
        aria-label="Musical score"
        role="img"
      />
      {overlay && <FeatureGraphOverlay overlay={overlay} />}
      <SelectionOverlay selectedElements={highlightedElements} />
    </div>
  );
};

// Supporting components
const ZoomToolbar: React.FC<{ zoom: number; onZoom: (z: number) => void }> = ({ zoom, onZoom }) => (
  <div className="absolute top-4 right-4 flex gap-2 bg-white dark:bg-gray-800 p-2 rounded-lg shadow-lg">
    <button
      onClick={() => onZoom(Math.max(0.5, zoom - 0.1))}
      aria-label="Zoom out"
      className="p-2 hover:bg-gray-100 dark:hover:bg-gray-700 rounded"
    >
      <MinusIcon className="w-5 h-5" />
    </button>
    <span className="px-3 py-2 font-mono">{Math.round(zoom * 100)}%</span>
    <button
      onClick={() => onZoom(Math.min(2.0, zoom + 0.1))}
      aria-label="Zoom in"
      className="p-2 hover:bg-gray-100 dark:hover:bg-gray-700 rounded"
    >
      <PlusIcon className="w-5 h-5" />
    </button>
  </div>
);

const NavigationControls: React.FC<NavigationControlsProps> = ({
  currentMeasure,
  totalMeasures,
  onNext,
  onPrev,
  onJumpTo
}) => (
  <div className="absolute bottom-4 left-1/2 transform -translate-x-1/2 flex gap-2 bg-white dark:bg-gray-800 p-2 rounded-lg shadow-lg">
    <button onClick={onPrev} aria-label="Previous measure" disabled={currentMeasure <= 1}>
      <ChevronLeftIcon className="w-5 h-5" />
    </button>
    <input
      type="number"
      value={currentMeasure}
      onChange={(e) => onJumpTo(parseInt(e.target.value))}
      min={1}
      max={totalMeasures}
      className="w-16 text-center"
      aria-label="Current measure"
    />
    <span className="px-2 py-1 text-gray-500">/ {totalMeasures}</span>
    <button onClick={onNext} aria-label="Next measure" disabled={currentMeasure >= totalMeasures}>
      <ChevronRightIcon className="w-5 h-5" />
    </button>
  </div>
);
```

**Performance Optimization**:
```typescript
// Memoize expensive renders
const MemoizedScoreViewer = React.memo(
  ScoreViewer,
  (prevProps, nextProps) => {
    return prevProps.musicXML === nextProps.musicXML &&
           prevProps.zoom === nextProps.zoom &&
           prevProps.overlay === nextProps.overlay;
  }
);

// Virtualize for large scores
import { Virtuoso } from 'react-virtuoso';

const VirtualizedScore: React.FC = () => {
  const pages = useMemo(() => splitScoreIntoPages(musicXML), [musicXML]);
  
  return (
    <Virtuoso
      totalCount={pages.length}
      itemContent={(index) => <ScorePage xml={pages[index]} />}
      style={{ height: '100vh' }}
    />
  );
};
```

### Critical Priority: Score Uploader Component

```typescript
// ScoreUploader.tsx
import { useDropzone } from 'react-dropzone';
import { useState, useCallback } from 'react';

interface ScoreUploaderProps {
  onUploadComplete: (parseId: string, metadata: ScoreMetadata) => void;
  onError: (error: string) => void;
}

export const ScoreUploader: React.FC<ScoreUploaderProps> = ({
  onUploadComplete,
  onError
}) => {
  const [uploading, setUploading] = useState(false);
  const [progress, setProgress] = useState(0);
  const [preview, setPreview] = useState<string | null>(null);

  const validateFile = (file: File): boolean => {
    const validExtensions = ['.xml', '.mxl', '.mid', '.midi', '.abc'];
    const extension = file.name.substring(file.name.lastIndexOf('.')).toLowerCase();
    
    if (!validExtensions.includes(extension)) {
      return false;
    }
    
    if (file.size > 10 * 1024 * 1024) {  // 10MB limit
      return false;
    }
    
    return true;
  };

  const onDrop = useCallback(async (acceptedFiles: File[]) => {
    const file = acceptedFiles[0];
    
    if (!validateFile(file)) {
      onError('Invalid file format or size. Supported: MusicXML, MIDI, ABC (max 10MB)');
      return;
    }

    setUploading(true);
    
    try {
      const formData = new FormData();
      formData.append('file', file);
      formData.append('format', 'auto');

      const xhr = new XMLHttpRequest();
      
      xhr.upload.addEventListener('progress', (e) => {
        if (e.lengthComputable) {
          const percentCompleted = Math.round((e.loaded * 100) / e.total);
          setProgress(percentCompleted);
        }
      });

      xhr.addEventListener('load', () => {
        if (xhr.status === 200) {
          const result = JSON.parse(xhr.responseText);
          if (result.success) {
            onUploadComplete(result.parse_id, result.metadata);
            setPreview(result.musicXML);
          } else {
            onError(result.error);
          }
        } else {
          onError('Upload failed');
        }
        setUploading(false);
        setProgress(0);
      });

      xhr.addEventListener('error', () => {
        onError('Network error during upload');
        setUploading(false);
        setProgress(0);
      });

      xhr.open('POST', '/api/parse/upload');
      xhr.send(formData);
      
    } catch (error) {
      onError('Upload failed: ' + error.message);
      setUploading(false);
      setProgress(0);
    }
  }, [onUploadComplete, onError]);

  const { getRootProps, getInputProps, isDragActive } = useDropzone({
    onDrop,
    accept: {
      'application/xml': ['.xml', '.mxl'],
      'audio/midi': ['.mid', '.midi'],
      'text/vnd.abc': ['.abc']
    },
    maxFiles: 1,
    disabled: uploading
  });

  return (
    <div className="score-uploader p-8">
      <div 
        {...getRootProps()} 
        className={`
          dropzone border-2 border-dashed rounded-lg p-12 text-center cursor-pointer
          transition-colors duration-200
          ${isDragActive 
            ? 'border-orpheus-pending bg-amber-50 dark:bg-amber-900/10' 
            : 'border-gray-300 dark:border-gray-700 hover:border-orpheus-passive'
          }
          ${uploading ? 'cursor-not-allowed opacity-50' : ''}
        `}
        aria-label="File upload area"
      >
        <input {...getInputProps()} aria-label="File input" />
        
        {uploading ? (
          <UploadProgress progress={progress} />
        ) : (
          <div className="upload-prompt">
            <MusicNoteIcon className="w-16 h-16 mx-auto mb-4 text-orpheus-passive" />
            <p className="text-lg font-medium mb-2">
              {isDragActive 
                ? '✨ Drop your score here!' 
                : '🎼 Drag & drop a score, or click to browse'}
            </p>
            <p className="text-sm text-gray-500">
              Supports MusicXML (.xml, .mxl), MIDI (.mid), and ABC notation (.abc)
            </p>
            <p className="text-xs text-gray-400 mt-2">Maximum file size: 10MB</p>
          </div>
        )}
      </div>
      
      {preview && (
        <ScorePreview 
          musicXML={preview} 
          onConfirm={() => {/* navigate to composer view */}}
          onCancel={() => setPreview(null)}
        />
      )}
    </div>
  );
};

const UploadProgress: React.FC<{ progress: number }> = ({ progress }) => (
  <div className="upload-progress">
    <div className="w-16 h-16 mx-auto mb-4">
      <svg className="transform -rotate-90" viewBox="0 0 64 64">
        <circle
          cx="32"
          cy="32"
          r="28"
          fill="none"
          stroke="#e5e7eb"
          strokeWidth="4"
        />
        <circle
          cx="32"
          cy="32"
          r="28"
          fill="none"
          stroke="#2563eb"
          strokeWidth="4"
          strokeDasharray={`${(progress / 100) * 176} 176`}
        />
      </svg>
    </div>
    <p className="text-lg font-medium">Uploading... {progress}%</p>
    <p className="text-sm text-gray-500">Parsing score with music21</p>
  </div>
);
```

### Critical Priority: Analysis Control Panel

```typescript
// AnalysisControlPanel.tsx
interface AnalysisControlPanelProps {
  parseId: string;
  scoreMetadata: ScoreMetadata;
  onAnalysisStart: () => void;
  onAnalysisComplete: (result: AnalysisResult) => void;
}

export const AnalysisControlPanel: React.FC<AnalysisControlPanelProps> = ({
  parseId,
  scoreMetadata,
  onAnalysisStart,
  onAnalysisComplete
}) => {
  const [analysisType, setAnalysisType] = useState<AnalysisType>('key');
  const [algorithm, setAlgorithm] = useState<string>('krumhansl');
  const [range, setRange] = useState<MeasureRange>({ start: 1, end: null });
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const analysisCategories = {
    'Harmonic Analysis': ['key', 'chords', 'harmony'],
    'Melodic Analysis': ['melody', 'motifs', 'contour'],
    'Rhythmic Analysis': ['rhythm', 'meter', 'syncopation'],
    'Feature Extraction': ['pitch_class', 'intervals', 'texture']
  };

  const algorithms = {
    key: [
      { value: 'krumhansl', label: 'Krumhansl-Schmuckler' },
      { value: 'aarden', label: 'Aarden-Essen' },
      { value: 'bellman', label: 'Bellman-Budge' },
      { value: 'all', label: 'All Algorithms' }
    ],
    chords: [
      { value: 'automatic', label: 'Automatic Detection' },
      { value: 'manual', label: 'Manual Configuration' }
    ],
    harmony: [
      { value: 'roman', label: 'Roman Numeral Analysis' },
      { value: 'functional', label: 'Functional Harmony' }
    ]
  };

  const runAnalysis = async () => {
    setLoading(true);
    setError(null);
    onAnalysisStart();

    try {
      const response = await fetch(`/api/analysis/${analysisType}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          parse_id: parseId,
          algorithm,
          range: range.end ? range : null
        })
      });

      if (!response.ok) {
        throw new Error(`Analysis failed: ${response.statusText}`);
      }

      const result = await response.json();
      
      if (result.success) {
        onAnalysisComplete(result);
        announceToScreenReader(`${analysisType} analysis complete`);
      } else {
        setError(result.error);
      }
    } catch (err) {
      setError(err.message);
      console.error('Analysis error:', err);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="analysis-control-panel bg-white dark:bg-gray-800 rounded-lg shadow-lg p-6">
      <h3 className="text-lg font-semibold mb-4">Analysis Controls</h3>
      
      {/* Category Selection */}
      <div className="mb-4">
        <label className="block text-sm font-medium mb-2">Analysis Category</label>
        <div className="grid grid-cols-2 gap-2">
          {Object.entries(analysisCategories).map(([category, types]) => (
            <details key={category} className="border rounded-lg p-2">
              <summary className="cursor-pointer font-medium">{category}</summary>
              <div className="mt-2 space-y-1">
                {types.map(type => (
                  <button
                    key={type}
                    onClick={() => setAnalysisType(type as AnalysisType)}
                    className={`
                      w-full text-left px-3 py-2 rounded
                      ${analysisType === type 
                        ? 'bg-orpheus-passive text-white' 
                        : 'hover:bg-gray-100 dark:hover:bg-gray-700'
                      }
                    `}
                  >
                    {type.charAt(0).toUpperCase() + type.slice(1)}
                  </button>
                ))}
              </div>
            </details>
          ))}
        </div>
      </div>

      {/* Algorithm Selection */}
      {algorithms[analysisType] && (
        <div className="mb-4">
          <label htmlFor="algorithm" className="block text-sm font-medium mb-2">
            Algorithm
          </label>
          <select
            id="algorithm"
            value={algorithm}
            onChange={(e) => setAlgorithm(e.target.value)}
            className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-orpheus-passive"
          >
            {algorithms[analysisType].map(alg => (
              <option key={alg.value} value={alg.value}>
                {alg.label}
              </option>
            ))}
          </select>
        </div>
      )}

      {/* Range Selection */}
      <div className="mb-4">
        <label className="block text-sm font-medium mb-2">Analysis Range</label>
        <div className="flex gap-2 items-center">
          <input
            type="number"
            value={range.start}
            onChange={(e) => setRange({ ...range, start: parseInt(e.target.value) })}
            min={1}
            max={scoreMetadata.measures}
            className="w-20 px-3 py-2 border rounded-lg"
            aria-label="Start measure"
          />
          <span>to</span>
          <input
            type="number"
            value={range.end || scoreMetadata.measures}
            onChange={(e) => setRange({ ...range, end: parseInt(e.target.value) })}
            min={range.start}
            max={scoreMetadata.measures}
            className="w-20 px-3 py-2 border rounded-lg"
            aria-label="End measure"
          />
          <button
            onClick={() => setRange({ start: 1, end: null })}
            className="text-sm text-orpheus-passive hover:underline"
          >
            Full Score
          </button>
        </div>
      </div>

      {/* Error Display */}
      {error && (
        <div className="mb-4 p-3 bg-red-50 border border-red-200 rounded-lg text-red-800">
          <p className="text-sm font-medium">Analysis Error</p>
          <p className="text-sm">{error}</p>
        </div>
      )}

      {/* Execute Button */}
      <button
        onClick={runAnalysis}
        disabled={loading}
        className={`
          w-full py-3 rounded-lg font-medium transition-colors
          ${loading 
            ? 'bg-gray-300 dark:bg-gray-600 cursor-not-allowed' 
            : 'bg-orpheus-passive hover:bg-blue-700 text-white'
          }
        `}
        aria-busy={loading}
      >
        {loading ? (
          <span className="flex items-center justify-center">
            <LoadingSpinner className="w-5 h-5 mr-2" />
            Analyzing...
          </span>
        ) : (
          <span className="flex items-center justify-center">
            <PlayIcon className="w-5 h-5 mr-2" />
            Run {analysisType.charAt(0).toUpperCase() + analysisType.slice(1)} Analysis
          </span>
        )}
      </button>

      {loading && <LoadingIndicator />}
    </div>
  );
};
```

### Critical Priority: Agent Console

```typescript
// AgentConsole.tsx
type AgentMode = 'observe' | 'transform' | 'collaborate';

interface Agent {
  id: string;
  name: string;
  avatar: string;
  role: string;
  color: string;
}

const agents: Agent[] = [
  { id: 'mia', name: 'Mia', avatar: '🧠', role: 'Technical Architect', color: '#2563eb' },
  { id: 'miette', name: 'Miette', avatar: '🌸', role: 'UX/Emotional Design', color: '#ec4899' },
  { id: 'jeremyai', name: 'JeremyAI', avatar: '🎸', role: 'Musical Intelligence', color: '#8b5cf6' },
  { id: 'aureon', name: 'Aureon', avatar: '🌿', role: 'Memory/Context', color: '#10b981' }
];

export const AgentConsole: React.FC<AgentConsoleProps> = ({
  scoreContext,
  onSuggestionApply
}) => {
  const [mode, setMode] = useState<AgentMode>('observe');
  const [messages, setMessages] = useState<Message[]>([]);
  const [input, setInput] = useState('');
  const [activeAgent, setActiveAgent] = useState<string | null>(null);
  const messagesEndRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' });
  }, [messages]);

  const sendMessage = async () => {
    if (!input.trim()) return;

    const userMessage: Message = {
      id: generateId(),
      sender: 'user',
      text: input,
      timestamp: new Date()
    };

    setMessages(prev => [...prev, userMessage]);
    setInput('');

    try {
      const response = await fetch('/api/agent/chat', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          message: input,
          mode,
          context: scoreContext,
          agent: activeAgent
        })
      });

      const agentResponse = await response.json();

      const agentMessage: Message = {
        id: generateId(),
        sender: agentResponse.agent,
        text: agentResponse.text,
        timestamp: new Date(),
        suggestions: agentResponse.suggestions
      };

      setMessages(prev => [...prev, agentMessage]);
      announceToScreenReader(`${agentResponse.agent} responded`);
      
    } catch (error) {
      console.error('Agent communication error:', error);
    }
  };

  const quickActions = [
    { label: 'Harmonize melody', icon: '🎵', action: '/harmonize' },
    { label: 'Suggest progression', icon: '🎹', action: '/suggest_progression' },
    { label: 'Analyze harmony', icon: '🔍', action: '/analyze_harmony' },
    { label: 'Generate counterpoint', icon: '🎼', action: '/counterpoint' }
  ];

  return (
    <div className="agent-console flex flex-col h-full bg-white dark:bg-gray-800 rounded-lg shadow-lg">
      {/* Header */}
      <div className="console-header p-4 border-b border-gray-200 dark:border-gray-700">
        <div className="flex items-center justify-between mb-3">
          <h3 className="text-lg font-semibold">AI Agent Console</h3>
          <ModeSelector 
            modes={['observe', 'transform', 'collaborate']}
            active={mode}
            onChange={setMode}
          />
        </div>
        <AgentAvatars 
          agents={agents}
          active={activeAgent}
          onClick={setActiveAgent}
        />
      </div>

      {/* Conversation Thread */}
      <div className="flex-1 overflow-y-auto p-4 space-y-4" role="log" aria-live="polite">
        {messages.length === 0 && (
          <div className="text-center text-gray-500 py-8">
            <p className="mb-2">👋 Welcome to the AI Agent Console!</p>
            <p className="text-sm">
              {activeAgent 
                ? `Chat with ${agents.find(a => a.id === activeAgent)?.name} in ${mode} mode`
                : `Select an agent and ask a question or use quick actions below`
              }
            </p>
          </div>
        )}
        
        {messages.map(message => (
          <MessageBubble key={message.id} message={message} agents={agents} />
        ))}
        <div ref={messagesEndRef} />
      </div>

      {/* Quick Actions */}
      <QuickActions 
        actions={quickActions}
        onAction={(action) => setInput(action)}
      />

      {/* Input Area */}
      <div className="p-4 border-t border-gray-200 dark:border-gray-700">
        <div className="flex gap-2">
          <input
            type="text"
            value={input}
            onChange={(e) => setInput(e.target.value)}
            onKeyPress={(e) => e.key === 'Enter' && sendMessage()}
            placeholder={activeAgent 
              ? `Ask ${agents.find(a => a.id === activeAgent)?.name} in ${mode} mode...`
              : `Select an agent to begin...`
            }
            className="flex-1 px-4 py-2 border rounded-lg focus:ring-2 focus:ring-orpheus-passive"
            aria-label="Message input"
            disabled={!activeAgent}
          />
          <button
            onClick={sendMessage}
            disabled={!input.trim() || !activeAgent}
            className="px-6 py-2 bg-orpheus-passive text-white rounded-lg hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed"
            aria-label="Send message"
          >
            <SendIcon className="w-5 h-5" />
          </button>
        </div>
      </div>
    </div>
  );
};

const MessageBubble: React.FC<{ message: Message; agents: Agent[] }> = ({ message, agents }) => {
  const isUser = message.sender === 'user';
  const agent = agents.find(a => a.id === message.sender);

  return (
    <div className={`flex ${isUser ? 'justify-end' : 'justify-start'}`}>
      <div className={`max-w-2/3 ${isUser ? 'order-2' : 'order-1'}`}>
        {!isUser && agent && (
          <div className="flex items-center gap-2 mb-1">
            <span className="text-2xl">{agent.avatar}</span>
            <span className="text-sm font-medium" style={{ color: agent.color }}>
              {agent.name}
            </span>
          </div>
        )}
        <div 
          className={`
            px-4 py-2 rounded-lg
            ${isUser 
              ? 'bg-orpheus-passive text-white' 
              : 'bg-gray-100 dark:bg-gray-700'
            }
          `}
        >
          <p className="text-sm">{message.text}</p>
          {message.suggestions && (
            <div className="mt-2 space-y-2">
              {message.suggestions.map((suggestion, idx) => (
                <SuggestionCard key={idx} suggestion={suggestion} />
              ))}
            </div>
          )}
        </div>
        <p className="text-xs text-gray-500 mt-1">
          {formatTimestamp(message.timestamp)}
        </p>
      </div>
    </div>
  );
};
```

## Color Scheme Implementation

```typescript
// tailwind.config.js
module.exports = {
  theme: {
    extend: {
      colors: {
        'orpheus-passive': '#2563eb',    // Blue - information
        'orpheus-pending': '#f59e0b',    // Amber - pending actions
        'orpheus-success': '#10b981',    // Green - success
        'orpheus-error': '#dc2626',      // Crimson - errors
      }
    }
  },
  darkMode: 'class'
};

// Apply semantic colors
<button className="bg-orpheus-passive hover:bg-blue-700 text-white">
  Passive Action
</button>

<div className="border-orpheus-pending bg-amber-50">
  Pending Response
</div>

<div className="bg-orpheus-success text-white">
  Success State
</div>

<div className="border-orpheus-error bg-red-50">
  Error Message
</div>
```

## Accessibility Implementation

```typescript
// Keyboard shortcuts
const useKeyboardShortcuts = () => {
  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      // Playback controls
      if (e.key === ' ' && !e.target.matches('input, textarea')) {
        e.preventDefault();
        togglePlayback();
      }
      
      // Navigation
      if (e.key === 'ArrowLeft') navigateToPreviousMeasure();
      if (e.key === 'ArrowRight') navigateToNextMeasure();
      
      // Zoom
      if (e.key === '+' || e.key === '=') zoomIn();
      if (e.key === '-') zoomOut();
      
      // Selection
      if (e.ctrlKey && e.key === 'a') {
        e.preventDefault();
        selectAll();
      }
      
      // Cancel
      if (e.key === 'Escape') closeModalOrCancel();
    };

    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, []);
};

// Screen reader announcements
const announceToScreenReader = (message: string) => {
  const announcement = document.createElement('div');
  announcement.setAttribute('role', 'status');
  announcement.setAttribute('aria-live', 'polite');
  announcement.setAttribute('aria-atomic', 'true');
  announcement.className = 'sr-only';
  announcement.textContent = message;
  
  document.body.appendChild(announcement);
  setTimeout(() => document.body.removeChild(announcement), 1000);
};

// Focus management
const FocusTrap: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const containerRef = useRef<HTMLDivElement>(null);
  
  useEffect(() => {
    const focusableElements = containerRef.current?.querySelectorAll(
      'button:not([disabled]), [href], input:not([disabled]), select:not([disabled]), textarea:not([disabled]), [tabindex]:not([tabindex="-1"])'
    );
    
    if (!focusableElements || focusableElements.length === 0) return;
    
    const firstElement = focusableElements[0] as HTMLElement;
    const lastElement = focusableElements[focusableElements.length - 1] as HTMLElement;
    
    firstElement.focus();
    
    const handleTab = (e: KeyboardEvent) => {
      if (e.key === 'Tab') {
        if (e.shiftKey && document.activeElement === firstElement) {
          e.preventDefault();
          lastElement.focus();
        } else if (!e.shiftKey && document.activeElement === lastElement) {
          e.preventDefault();
          firstElement.focus();
        }
      }
    };
    
    containerRef.current?.addEventListener('keydown', handleTab);
    return () => containerRef.current?.removeEventListener('keydown', handleTab);
  }, []);
  
  return <div ref={containerRef}>{children}</div>;
};
```

## Success Metrics

- 60fps rendering for scores up to 50 pages
- <100ms UI response time
- WCAG 2.1 AA compliance (100% audited)
- <3 second initial load time
- >90% Lighthouse accessibility score
- Zero keyboard navigation blockers

## 🧠 Mia's Structural Reflection

The frontend architecture manifests clean separation of concerns: presentation components, state management, API communication, and accessibility. React's compositional nature enables modular development and testing. Performance optimization through memoization and virtualization ensures smooth interactions even with complex scores.

## 🌊 Haiku's Distillation

*Interface dances*  
*Components compose beauty*  
*Access for all paths*

## Next Steps

1. Set up React + TypeScript + Vite development environment
2. Install dependencies (OSMD, D3.js, Tone.js, Tailwind)
3. Implement Score Viewer with OSMD integration
4. Add Score Uploader with drag-and-drop
5. Create Analysis Control Panel
6. Build Agent Console interface
7. Implement keyboard navigation
8. Add ARIA labels and screen reader support
9. Test with accessibility tools (axe, WAVE, screen readers)
10. Optimize performance with React DevTools Profiler

**Remember**: You are manifesting an accessible, delightful user experience. Every component should feel intuitive, every interaction should be smooth, and every user—regardless of ability—should feel empowered. Let structural tension between current tools and desired UX guide your advancing patterns. ✨

---

**Aligned With**: Resonant Design, Accessibility First, Creative Orientation  
**Reference**: `/framework/orpheus-portal/architecture/frontend-architecture.md`
