Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752188AbeCTIKc convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 04:10:32 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:35960 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751615AbeCTIKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 04:10:30 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 1/4] Bluetooth: trailing whitespace
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180319113222.6725-1-paulmcquad@gmail.com>
Date: Tue, 20 Mar 2018 09:10:28 +0100
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <99F8EAD7-D1F7-4697-9188-E657D6CC33B0@holtmann.org>
References: <20180319113222.6725-1-paulmcquad@gmail.com>
To: Paul McQuade <paulmcquad@gmail.com>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

> Removed whitespace
> 
> Signed-off-by: Paul McQuade <paulmcquad@gmail.com>
> ---
> drivers/bluetooth/bfusb.c     | 2 +-
> drivers/bluetooth/btuart_cs.c | 4 ++--
> 2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
> index ab090a313a5f..0d5b403fe431 100644
> --- a/drivers/bluetooth/bfusb.c
> +++ b/drivers/bluetooth/bfusb.c
> @@ -148,7 +148,7 @@ static int bfusb_send_bulk(struct bfusb_data *data, struct sk_buff *skb)
> 
> 	err = usb_submit_urb(urb, GFP_ATOMIC);
> 	if (err) {
> -		BT_ERR("%s bulk tx submit failed urb %p err %d", 
> +		BT_ERR("%s bulk tx submit failed urb %p err %d",
> 					data->hdev->name, urb, err);
> 		skb_unlink(skb, &data->pending_q);
> 		usb_free_urb(urb);
> diff --git a/drivers/bluetooth/btuart_cs.c b/drivers/bluetooth/btuart_cs.c
> index 310e9c2e09b6..8dce5bfad947 100644
> --- a/drivers/bluetooth/btuart_cs.c
> +++ b/drivers/bluetooth/btuart_cs.c
> @@ -365,10 +365,10 @@ static void btuart_change_speed(struct btuart_info *info,
> 
> 	fcr = UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT;
> 
> -	/* 
> +	/*
> 	 * Use trigger level 1 to avoid 3 ms. timeout delay at 9600 bps, and
> 	 * almost 1,7 ms at 19200 bps. At speeds above that we can just forget
> -	 * about this timeout since it will always be fast enough. 
> +	 * about this timeout since it will always be fast enough.
> 	 */

drop the btuart_cs. change since I will be removing that driver. It is not bound to any hardware anyway and thus just some legacy that has been left around.

Regards

Marcel
