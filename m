Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752934AbeBTQgc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:36:32 -0500
Received: from ms.lwn.net ([45.79.88.28]:32820 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752883AbeBTQgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:36:31 -0500
Date: Tue, 20 Feb 2018 09:36:28 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Du, Changbin" <changbin.du@intel.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Ingo Molnar <mingo@kernel.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/17] trace doc: convert trace/ftrace.txt to rst format
Message-ID: <20180220093628.32067640@lwn.net>
In-Reply-To: <20180220102644.38218f27@gandalf.local.home>
References: <1518845990-20733-1-git-send-email-changbin.du@intel.com>
        <1518845990-20733-6-git-send-email-changbin.du@intel.com>
        <CAOFm3uE78DosAoZDNfD_YRaGPhpxW=4_cd3d9MafV-mdk5BuxQ@mail.gmail.com>
        <20180220132700.iz27aumgy5o2agp3@intel.com>
        <20180220102644.38218f27@gandalf.local.home>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Feb 2018 10:26:44 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> One it should be a separate patch. Two, how does SPDX deal with dual
> licenses?

Separate them with "OR" on a single line.  See
Documentation/process/license-rules.rst for details.

jon
