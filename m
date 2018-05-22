Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751600AbeEVHZO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 03:25:14 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:46571 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbeEVHZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 03:25:13 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH] drivers: bluetooth: hci_serdev: Removed unnecessary curly
 braces
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1526333927-21222-1-git-send-email-vaibhavmurkute88@gmail.com>
Date: Tue, 22 May 2018 09:25:11 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <C40D68D9-E167-40A3-81F0-5B272D455627@holtmann.org>
References: <1526333927-21222-1-git-send-email-vaibhavmurkute88@gmail.com>
To: Vaibhav Murkute <vaibhavmurkute88@gmail.com>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vaibhav,

> checkpatch.pl shows a warning for these unnecessary curly braces.
> so just removed those curly braces.
> 
> Signed-off-by: Vaibhav Murkute <vaibhavmurkute88@gmail.com>
> ---
> drivers/bluetooth/hci_serdev.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
