Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752754AbeDLNSU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 09:18:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38028 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752062AbeDLNST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 09:18:19 -0400
Date: Thu, 12 Apr 2018 08:18:18 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Laura Abbott <labbott@redhat.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCHv2] objtool: Support HOSTCFLAGS and HOSTLDFLAGS
Message-ID: <20180412131818.rdp5fj6rvp2mu646@treble>
References: <20180411200432.3493-1-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180411200432.3493-1-labbott@redhat.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 01:04:32PM -0700, Laura Abbott wrote:
> It may be useful to compile host programs with different flags (e.g.
> hardening). Ensure that objtool picks up the appropriate flags.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v2: Drop several flags that are already defined in HOSTCFLAGS

Thanks Laura.  Changes to the objtool makefile usually go through the
-tip tree, so I'll run it through some testing and then send it along.

-- 
Josh
