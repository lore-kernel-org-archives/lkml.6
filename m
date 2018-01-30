Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752680AbeA3Dnc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 29 Jan 2018 22:43:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43136 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752186AbeA3Dnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jan 2018 22:43:31 -0500
Date: Mon, 29 Jan 2018 21:43:29 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Martin Steigerwald <martin@lichtvoll.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Requirements for retpoline in Linux 4.15 (was: Re: Linux 4.15)
Message-ID: <20180130034329.xulxk44ex2bxw7ob@treble>
References: <CA+55aFzARtx-nA=d1j7vLOLf4FHMJLyRiQ-PKkoexJuTUHogdw@mail.gmail.com>
 <1517219630.6624.120.camel@infradead.org>
 <5326624.8I3Ve3uUFt@merkaba>
 <5520835.tArHHOCcxE@merkaba>
 <1517225725.6624.136.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1517225725.6624.136.camel@infradead.org>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2018 at 11:35:25AM +0000, David Woodhouse wrote:
> If they have explicit asm which has indirect jumps, that would still be
> a problem. We just need to port objtool into the kernel and do it at
> module load time, to check for that... :)

Darnit, you sniffed out my April Fool's plan.

-- 
Josh
