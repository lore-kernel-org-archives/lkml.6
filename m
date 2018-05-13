Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752132AbeEMWt4 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 18:49:56 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38140 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752018AbeEMWtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 18:49:55 -0400
X-Google-Smtp-Source: AB8JxZps6R5v2HVcGgXL64dJISB+HZi34jMnfyKkZHAPfyWOshGexUM8z2sQZJTuVUfVyX1wpniFmMbgiQbs+0iWi/I=
MIME-Version: 1.0
In-Reply-To: <1526076752-5871-1-git-send-email-vaibhavmurkute88@gmail.com>
References: <1526076752-5871-1-git-send-email-vaibhavmurkute88@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 14 May 2018 01:49:54 +0300
Message-ID: <CAHp75VfLuiyLC-C=0HKAeWH3-Qd_fJ6WCOTN7s4VAwLkRzakdw@mail.gmail.com>
Subject: Re: [PATCH] drivers: bluetooth: hci_serdev: Removed unnecessary curly braces
To: Vaibhav Murkute <vaibhavmurkute88@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 12, 2018 at 1:12 AM, Vaibhav Murkute
<vaibhavmurkute88@gmail.com> wrote:
> checkpatch.pl shows a warning for these unnecessary curly braces.
> so just removed those curly braces.
>
> Signed-off-by: Vaibhav Murkute <vaibhavmurkute88@gmail.com>
> ---
>  drivers/bluetooth/hci_serdev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
> index e0e6461..137c314 100644
> --- a/drivers/bluetooth/hci_serdev.c
> +++ b/drivers/bluetooth/hci_serdev.c
> @@ -204,9 +204,9 @@ static int hci_uart_setup(struct hci_dev *hdev)
>                 return 0;
>         }
>
> -       if (skb->len != sizeof(*ver)) {
> +       if (skb->len != sizeof(*ver))
>                 bt_dev_err(hdev, "Event length mismatch for version info");
> -       }
> +
>
>         kfree_skb(skb);
>         return 0;

Why did you add redundant empty line(s) instead?


-- 
With Best Regards,
Andy Shevchenko
