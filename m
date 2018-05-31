Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754042AbeEaHga (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 03:36:30 -0400
Received: from mo-csw1114.securemx.jp ([210.130.202.156]:56626 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753846AbeEaHg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 03:36:26 -0400
X-Iguazu-Qid: 2wGrJrlV9KH54BsbsT
X-Iguazu-QSIG: v=1; s=0; t=1527752169; q=2wGrJrlV9KH54BsbsT; m=bhPbpMgbe+LeYDy/ByYH77a9/BKJPJJRN9BEHj16BZU=
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        "'Davidlohr Bueso'" <dbueso@suse.de>,
        "'Joe Lawrence'" <joe.lawrence@redhat.com>,
        "'Andrea Arcangeli'" <aarcange@redhat.com>,
        "'Manfred Spraul'" <manfred@colorfullife.com>,
        "'Andrew Morton'" <akpm@linux-foundation.org>,
        "'Linus Torvalds'" <torvalds@linux-foundation.org>
References: <20180528100202.045206534@linuxfoundation.org> <20180528100203.357731085@linuxfoundation.org> <005601d3f888$37f266f0$a7d734d0$@toshiba.co.jp> <20180531063408.GA7744@kroah.com>
In-Reply-To: <20180531063408.GA7744@kroah.com>
Subject: RE: [PATCH 4.4 011/268] Revert "ipc/shm: Fix shmat mmap nil-page protection"
Date: Thu, 31 May 2018 16:36:04 +0900
X-TSB-HOP: ON
Message-ID: <000001d3f8b2$07fc2ab0$17f48010$@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIIWZ/WGnaRCO8XjPKf6QObGDbsxQGPOkphAztm2LEBjYCP2aOt725A
Content-Language: ja
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: 'Greg Kroah-Hartman' [mailto:gregkh@linuxfoundation.org]
..
> Thanks for letting us know, but this was reported already.  See the
> emails on lkml with the subject:
> 	Subject: Re: [PATCH 4.16 000/272] 4.16.13-stable review
> from Davidlohr Bueso
> 	Message-ID: <20180528213039.yy2madue67njkmw5@linux-n805>
> 
> where he discusses that the LTP test is incorrect and that the kernel
> change is correct and that LTP is going to be fixed because of this.

OK, thank you for the information!

Regards,
Daniel
