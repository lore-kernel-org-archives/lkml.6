Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751957AbeCOBAW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 21:00:22 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48157 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751537AbeCOBAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 21:00:21 -0400
X-ME-Sender: <xms:pMWpWkk_Ii6jb-iBlBvz7dTjY8_mtc0coJ79t76D_lxewAOAQ_iMSQ>
Date: Wed, 14 Mar 2018 22:00:14 -0300
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: Borislav Petkov <bp@alien8.de>
Cc: X86 ML <x86@kernel.org>, Emanuel Czirai <xftroxgpx@protonmail.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/microcode: Fix CPU synchronization routine
Message-ID: <20180315010014.xsedkarzrgqiunxf@khazad-dum.debian.net>
References: <20180314183615.17629-1-bp@alien8.de>
 <20180314183615.17629-2-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314183615.17629-2-bp@alien8.de>
X-GPG-Fingerprint1: 4096R/0x0BD9E81139CB4807: C467 A717 507B BAFE D3C1  6092
 0BD9 E811 39CB 4807
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Mar 2018, Borislav Petkov wrote:
> Also, since the update is serialized and it also takes a couple of
> thousand cycles per microcode engine, increase the exit timeout by the
> number of CPUs on the system.

Maybe on AMD it is that fast ;-)

Intel takes anything from twenty thousand cycles to several *million*
cycles per core, proportional to microcode update size.

-- 
  Henrique Holschuh
