Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751101AbeBQOVo (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 09:21:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:40980 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751011AbeBQOVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 09:21:43 -0500
Date: Sat, 17 Feb 2018 15:21:32 +0100
From: Borislav Petkov <bp@suse.de>
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Ashok Raj <ashok.raj@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/microcode: Check microcode revision before updating
 sibling threads
Message-ID: <20180217142132.GA30848@pd.tnic>
References: <1518806808-4074-1-git-send-email-ashok.raj@intel.com>
 <20180217134247.sccdynjiqnk2mjby@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180217134247.sccdynjiqnk2mjby@khazad-dum.debian.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 17, 2018 at 11:42:48AM -0200, Henrique de Moraes Holschuh wrote:
> I wonder when this broke,

It didn't break - we're just printing the update only once.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
