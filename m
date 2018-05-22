Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751672AbeEVO1h (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 10:27:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:44675 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751236AbeEVO1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 10:27:33 -0400
Date: Tue, 22 May 2018 16:27:30 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Joe Lawrence <joe.lawrence@redhat.com>
cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, Petr Mladek <pmladek@suse.com>,
        =?ISO-8859-2?Q?Libor_Pech=E1=E8ek?= <lpechacek@suse.com>,
        Nicolai Stange <nstange@suse.de>, Artem Savkov <asavkov@redhat.com>
Subject: Re: [PATCH v4 0/1] Add livepatch kselftests
In-Reply-To: <1524680930-28168-1-git-send-email-joe.lawrence@redhat.com>
Message-ID: <alpine.LSU.2.21.1805221617160.1847@pobox.suse.cz>
References: <1524680930-28168-1-git-send-email-joe.lawrence@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2018, Joe Lawrence wrote:

> This round incorporates feedback from SUSE folks, Miroslav, Petr and
> Libor.  Thanks for the reviews and feedback!
> 
> Like the previous version, this applies on top of Petr's shadow variable
> changes and the atomic replace patchset.

I skimmed through it and I did not find anything suspicious. It also works 
as advertised. It'd great if someone from kselftest ML took a look.

Thanks,
Miroslav
