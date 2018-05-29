Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965630AbeE2RxS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 13:53:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:45251 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965391AbeE2RxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 13:53:17 -0400
Date: Tue, 29 May 2018 19:53:14 +0200
From: Borislav Petkov <bp@suse.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Williams, Dan J" <dan.j.williams@intel.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3 V2] x86/mce: Fix incorrect "Machine check from
 unknown source" message
Message-ID: <20180529175313.GG19870@zn.tnic>
References: <cover.1527283897.git.tony.luck@intel.com>
 <52e049a497e86fd0b71c529651def8871c804df0.1527283897.git.tony.luck@intel.com>
 <20180528204923.GB30792@zn.tnic>
 <20180529161549.GB935@agluck-desk>
 <20180529174105.GF19870@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7D31E24F@ORSMSX110.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7D31E24F@ORSMSX110.amr.corp.intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 05:50:48PM +0000, Luck, Tony wrote:
> Ah. That would be because I forgot to "git add" before "git commit --amend" :-(

Oh, I know the situation very well. :)

> I had put:
> 
> 		(void) mce_severity(&m, cfg->tolerant, &msg, true);
> 
> but either works.

Right.

> Will look. I hope you didn't do too much to make the stable backport more difficult.

Nah, the cleanups will all go ontop. This is just a dirty branch to show
my intention but yours go first and then the cleanup.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
