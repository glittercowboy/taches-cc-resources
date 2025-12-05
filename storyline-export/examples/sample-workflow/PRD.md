# Product Requirements: Simple Task Manager

## Overview

Build a minimal task management application for individual users to track their daily tasks. This is a learning project demonstrating story-driven development workflow.

## Goals

**Primary goal:** Enable users to create, view, complete, and delete tasks.

**Success metric:** User can manage their task list without friction.

## Target Users

**Primary persona:** Individual knowledge worker
- Needs simple task tracking
- Wants to see what's done vs pending
- Doesn't need collaboration features

## Core Features

### 1. User Authentication
Users need accounts to save their tasks.
- Sign up with email/password
- Login to existing account
- Basic session management

### 2. Task Management
Core CRUD operations for tasks.
- Create task with title and description
- View list of all tasks
- Mark task as complete/incomplete
- Delete task

### 3. Task Organization
Help users organize their tasks.
- Categorize tasks (Work, Personal, Shopping)
- Filter tasks by category
- See completed vs pending tasks separately

## Out of Scope (v1)

- Collaboration / sharing tasks
- Due dates and reminders
- Task priorities
- Mobile app (web only)
- Social features

## Technical Constraints

- Web application (React frontend, Node backend)
- PostgreSQL database
- REST API
- Deploy to Vercel (frontend) and Railway (backend)

## Success Criteria

MVP is successful when:
- [ ] User can sign up and login
- [ ] User can create, view, complete, and delete tasks
- [ ] Tasks persist across sessions
- [ ] User can filter by category
- [ ] Clean, usable UI
- [ ] Deployed and accessible via URL

## Timeline

Target: Ship v1.0 in 2-3 weeks

---

**Next step:** Run `/epic-creator examples/sample-workflow/PRD.md`
