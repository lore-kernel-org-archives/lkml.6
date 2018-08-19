Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7D8C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 07:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1688120893
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 07:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1688120893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbeHSKhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 06:37:25 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:39427 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbeHSKhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 06:37:25 -0400
Received: from excalibur.cnev.de ([84.44.150.59]) by mrelayeu.kundenserver.de
 (mreue102 [212.227.15.183]) with ESMTPSA (Nemesis) id
 0LhvjW-1gDzXW0wqo-00nBE8; Sun, 19 Aug 2018 09:26:16 +0200
Received: from karsten by excalibur.cnev.de with local (Exim 4.89)
        (envelope-from <merker@debian.org>)
        id 1frI6I-0001J9-Am; Sun, 19 Aug 2018 09:26:14 +0200
Date:   Sun, 19 Aug 2018 09:26:14 +0200
From:   Karsten Merker <merker@debian.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] RISC-V Updates for the 4.19 Merge Window
Message-ID: <20180819072614.etl7izdicabsffn3@excalibur.cnev.de>
References: <mhng-4afb9897-29ed-4eb4-88d7-6cfb09a0a65c@palmer-si-x1c4>
 <20180818133759.GA20049@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180818133759.GA20049@roeck-us.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:2/wesicPRaqSXplJpEzZtWT5JeQK4mZbxfURiPUZlOzBYD3szQq
 RKFQgp/m7LR3wX8dddV4HnFjXDEE37KmHT5y5SZXCgCSdBSKLElVzTwbTi8fVvv69ynC58q
 DeT/InPBWHFrjr6vTKLJWfWgrp9yMKkHvlmHcg2DK1ai5gqnpzfNZGjbiDJZeHtYnDG+d24
 JT9u7rWVb4CSV1DM7QenA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4AOT+aak77Q=:J+mYrc4yByc6SiIU4XoOk7
 dXyrkwh9JT5LgUoPY1evnFVW/FKqT3US7ByH0iO9jwF//cJj+hzeYWi5poEKVx94TBRbTcgi/
 Mr4lA5wv+oj6PoeOokzR0Gc7pcNjukYWx8Mz+rEeNa7IXvHECgCsjA7bIigQP1XnyNBHjEDw2
 eAa+oT7x9nNKRTn2neHQZAA7g/5xrp9H0mWk3HIeqyf3kxDZe8UJbY8E2VnBBZFr7xhVdtDQw
 ntv2tFDN7swCAtlkFpkHbHVr9GcCJ2DWvrkwrrbE4KyhF2HhXDCgB4XvS5xHbGcD45PmI8LzB
 NnArSOm/Ew3psegF/ClVWWf5SkvnIplQbfR7LYQAKoAR0nLUqnOYSstb+xCCaM3Ywu7+jaans
 9f0GqiS25MdQbBBPOrGe8AoPFvYNCbAkOp1eVq0LkOD1bM63rLfqPR2x9vC59/NHhTn8seMSu
 H/36T/Sh/3iIQgz5daqehqGgjAUl/TZ0uLxRTfN1WezRNAzN2nrgFG7ARFYmBaSRuN8EtqoBh
 gkJFDztEBk3SZZ+EirHPhk176Iw7JQBEyeTzjvYsgkWqp+dJwo8oMsacxFagoV7YThtFe6Usl
 c3boMDGKiBV9V/Gg1HVtW4CcLlBo2hDfjAXVOEiDFNHQ0ubNGW6uJo3bpMNbfnYu6PDUmrBv7
 KgVoD/uAcyKfyX29rTWwEeXiwg2WANml4DfEmXyyPP3q7LFyuqRnDxc0SGg90Jyy25pY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2018 at 06:37:59AM -0700, Guenter Roeck wrote:
> On Fri, Aug 17, 2018 at 01:28:11PM -0700, Palmer Dabbelt wrote:
> [ ... ]
> > 
> > This tag boots a Fedora root filesystem on QEMU's master branch for me,
> > and before this morning's rebase (from 4.18-rc8 to 4.18) it booted on
> > the HiFive Unleashed.
> 
> Do you have vmlinux embedded in bbl ?
> 
> With separate bbl and vmlinux, and the following qemu command line 
> (with qemu 3.0)
> 
> qemu-system-riscv64 -M virt -m 512M -no-reboot \
> 	-bios bbl -kernel vmlinux \
> 	-netdev user,id=net0 -device virtio-net-device,netdev=net0 \
> 	-device virtio-blk-device,drive=d0 \
> 	-drive file=rootfs.ext2,if=none,id=d0,format=raw \
> 	-append 'root=/dev/vda rw console=ttyS0,115200' \
> 	-nographic -monitor none
> 
> all I get is
> 
> rom: requested regions overlap (rom mrom.reset. free=0x000000000001cbe8, addr=0x0000000000001000)
> 
> However, the she system boots fine with the same qemu command line if I use qemu
> built from https://github.com/riscv/riscv-qemu.git, branch qemu-for-upstream.

Hello,

AFAICS the qemu patch that adds support for handling separate bbl
and kernel images, i.e.

  https://github.com/riscv/riscv-qemu/commit/6338416ecf4717197c635b5abf9c17465d2d0da0

hasn't yet made it into upstream qemu, so using the "-bios"
option for bbl generally doesn't work with (upstream) qemu 3.0.

Regards,
Karsten
-- 
Gem. Par. 28 Abs. 4 Bundesdatenschutzgesetz widerspreche ich der Nutzung
sowie der Weitergabe meiner personenbezogenen Daten für Zwecke der
Werbung sowie der Markt- oder Meinungsforschung.
