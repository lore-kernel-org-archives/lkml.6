Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753599AbeBGIzz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 03:55:55 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:51364 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753553AbeBGIzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 03:55:52 -0500
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH v2 0/5] lite fixes for ath3k
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180204210947.31002-1-mussitantesmortem@gmail.com>
Date: Wed, 7 Feb 2018 09:55:50 +0100
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <068BF707-63F0-4AE5-82A2-9611FA44A00B@holtmann.org>
References: <20180204205934.12117-4-mussitantesmortem@gmail.com>
 <20180204210947.31002-1-mussitantesmortem@gmail.com>
To: Maxim Zhukov <mussitantesmortem@gmail.com>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxim,

> Sorry for the last series of patches
> 
> Maxim Zhukov (5):
>  drivers: bluetooth: ath3k: replace hardcode numbers with define
>  drivers: bluetooth: ath3k: do not init variables
>  drivers: bluetooth: ath3k: remove blank line after if
>  drivers: bluetooth: ath3k: Fix warning: quoted string split across lines
>  drivers: bluetooth: ath3k: fix checkpatch warning
> 
> drivers/bluetooth/ath3k.c | 28 ++++++++++++++++------------
> 1 file changed, 16 insertions(+), 12 deletions(-)

all 5 patches have been applied to bluetooth-next tree.

Regards

Marcel
