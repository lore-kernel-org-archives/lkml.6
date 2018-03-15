Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeCOBCf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 21:02:35 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35298 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751943AbeCOBCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 21:02:33 -0400
Date: Thu, 15 Mar 2018 02:01:52 +0100
From: Borislav Petkov <bp@alien8.de>
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: X86 ML <x86@kernel.org>, Emanuel Czirai <xftroxgpx@protonmail.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/microcode: Fix CPU synchronization routine
Message-ID: <20180315010152.GE11061@pd.tnic>
References: <20180314183615.17629-1-bp@alien8.de>
 <20180314183615.17629-2-bp@alien8.de>
 <20180315010014.xsedkarzrgqiunxf@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180315010014.xsedkarzrgqiunxf@khazad-dum.debian.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 10:00:14PM -0300, Henrique de Moraes Holschuh wrote:
> Intel takes anything from twenty thousand cycles to several *million*
> cycles per core, proportional to microcode update size.

Got any hard data to back that claim up?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
