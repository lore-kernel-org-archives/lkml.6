Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752130AbeCTIJg convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 04:09:36 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:57753 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751712AbeCTIJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 04:09:33 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 3/4] Bluetooth: trailing statements
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180319113222.6725-3-paulmcquad@gmail.com>
Date: Tue, 20 Mar 2018 09:09:31 +0100
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <49319155-4ADA-4913-8177-B4E2AE1D83EA@holtmann.org>
References: <20180319113222.6725-1-paulmcquad@gmail.com>
 <20180319113222.6725-3-paulmcquad@gmail.com>
To: Paul McQuade <paulmcquad@gmail.com>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

> trailing statements should be on next line
> 
> Signed-off-by: Paul McQuade <paulmcquad@gmail.com>
> ---
> drivers/bluetooth/hci_ll.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
> index 1b4417a623a4..06d859d82de8 100644
> --- a/drivers/bluetooth/hci_ll.c
> +++ b/drivers/bluetooth/hci_ll.c
> @@ -567,7 +567,8 @@ static int read_local_version(struct hci_dev *hdev)
> 	version = le16_to_cpu(ver->lmp_subver);
> 
> out:
> -	if (err) bt_dev_err(hdev, "Failed to read TI version info: %d", err);
> +	if (err)
> +	bt_dev_err(hdev, "Failed to read TI version info: %d", err);

actually this needs to be indented one further since it is the action of the if clause.

Regards

Marcel
