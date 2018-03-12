Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932485AbeCLQLp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 12:11:45 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:56435 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752156AbeCLQL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 12:11:27 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 4/5] Bluetooth: btmrvl: Delete an unnecessary variable
 initialisation in btmrvl_sdio_card_to_host()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <2c2f8733-c5c0-cb2f-62eb-4fa360ee271e@users.sourceforge.net>
Date: Mon, 12 Mar 2018 17:11:25 +0100
Cc: linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <4A308847-949D-4805-9508-4D016B105A64@holtmann.org>
References: <8d050f76-aed1-7b6b-8778-a78aef34d4ea@users.sourceforge.net>
 <2c2f8733-c5c0-cb2f-62eb-4fa360ee271e@users.sourceforge.net>
To: SF Markus Elfring <elfring@users.sourceforge.net>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

> The variable "payload" will eventually be set to an appropriate pointer
> a bit later. Thus omit the explicit initialisation at the beginning.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
> drivers/bluetooth/btmrvl_sdio.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
