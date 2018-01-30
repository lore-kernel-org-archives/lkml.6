Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752494AbeA3CLI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 29 Jan 2018 21:11:08 -0500
Received: from ozlabs.org ([103.22.144.67]:59263 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752076AbeA3CLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jan 2018 21:11:07 -0500
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christian Zigotzky <chzigotzky@xenosoft.de>, linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org, peterz@infradead.org, linux-kernel@vger.kernel.org,
        npiggin@gmail.com, oohall@gmail.com, anton@samba.org, paulus@samba.org,
        tglx@linutronix.de
Subject: Re: [PATCH 07/11] powerpc/64s: Add support for RFI flush of L1-D cache
In-Reply-To: <d73cc972-420d-4106-cc08-0d0683435afa@xenosoft.de>
References: <20180108165453.26066-1-mpe@ellerman.id.au> <20180108165453.26066-7-mpe@ellerman.id.au> <d73cc972-420d-4106-cc08-0d0683435afa@xenosoft.de>
Date: Tue, 30 Jan 2018 13:11:05 +1100
Message-ID: <87mv0w85ae.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Zigotzky <chzigotzky@xenosoft.de> writes:

> FYI:
>
> A-EON AmigaOne X1000 (CPU P.A. Semi PWRficient PA6T-1682M with two PA6T 
> cores):
>
> /sys/devices/system/cpu/vulnerabilities/
>
> -r--r--r-- 1 root root 4096 Jan 25 09:38 meltdown
> -r--r--r-- 1 root root 4096 Jan 25 09:38 spectre_v1
> -r--r--r-- 1 root root 4096 Jan 25 09:38 spectre_v2
>
> meltdown Vulnerable
> spectre_v1 Not affected
> spectre_v2 Not affected

Which may or may not be true, this is still all a work in progress.

cheers
