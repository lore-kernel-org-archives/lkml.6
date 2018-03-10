Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751251AbeCJRNy (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 12:13:54 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:46112 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750985AbeCJRNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 12:13:52 -0500
X-Google-Smtp-Source: AG47ELt/MKK1LHAspxbPhY/411dqp2AdZYt+nWKH1t8En8uJU9GHU7QVAu41McNYhMMEVCJx23FV0wmZGgQ0iKtwiO4=
MIME-Version: 1.0
In-Reply-To: <20180201164714.25709-1-malat@debian.org>
References: <20180201164714.25709-1-malat@debian.org>
From: Mathieu Malaterre <malat@debian.org>
Date: Sat, 10 Mar 2018 18:13:31 +0100
X-Google-Sender-Auth: ASv81O0gI6ewQSMi2RrAfSC_X9A
Message-ID: <CA+7wUsxTw9mZGiYOKcDsTG72jfTxc95eh-Do2pL9uXxTy+dpgw@mail.gmail.com>
Subject: Re: [PATCH] driver/rtc: remove a warning during scripts/kernel-doc step
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping ?

On Thu, Feb 1, 2018 at 5:47 PM, Mathieu Malaterre <malat@debian.org> wrote:
> During compilation using W=1 one would get:
>
> drivers/rtc/systohc.c:11: info: Scanning doc for rtc_set_ntp_time
> drivers/rtc/systohc.c:23: warning: bad line:  (
>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  drivers/rtc/systohc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/rtc/systohc.c b/drivers/rtc/systohc.c
> index 0c177647ea6c..718293d72426 100644
> --- a/drivers/rtc/systohc.c
> +++ b/drivers/rtc/systohc.c
> @@ -20,7 +20,7 @@
>   * cases.
>   *
>   * -EPROTO is returned if now.tv_nsec is not close enough to *target_nsec.
> - (
> + *
>   * If temporary failure is indicated the caller should try again 'soon'
>   */
>  int rtc_set_ntp_time(struct timespec64 now, unsigned long *target_nsec)
> --
> 2.11.0
>
