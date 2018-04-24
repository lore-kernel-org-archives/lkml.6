Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752901AbeDXO0l (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 10:26:41 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:44065 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750935AbeDXO0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 10:26:38 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH] Bluetooth: btusb: add ID for LiteOn 04ca:301a
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180423221707.82190-1-mka@chromium.org>
Date: Tue, 24 Apr 2018 16:26:36 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>, Vic Wei <vwei@codeaurora.org>
Content-Transfer-Encoding: 7bit
Message-Id: <F14DBB50-02E6-4B03-8C2D-A885A0CDD9D6@holtmann.org>
References: <20180423221707.82190-1-mka@chromium.org>
To: Matthias Kaehlcke <mka@chromium.org>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

> Contains a QCA6174A chipset, with USB BT. Let's support loading
> firmware on it.
> 
> From usb-devices:
> T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
> D:  Ver= 2.01 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=04ca ProdID=301a Rev= 0.01
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> 
> Signed-off-by: Vic Wei <vwei@codeaurora.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> drivers/bluetooth/btusb.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel
