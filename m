Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752612AbeEHLDo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 07:03:44 -0400
Received: from forward3j.cmail.yandex.net ([5.255.227.21]:41816 "EHLO
        forward3j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750973AbeEHLDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 07:03:43 -0400
Authentication-Results: mxback6j.mail.yandex.net; dkim=pass header.i=@yandex.ru
From: Evgeniy Polyakov <zbr@ioremap.net>
Envelope-From: drustafa@yandex.ru
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
In-Reply-To: <cd5b6e6a8d51820ee158127cdd50e44645c44ee7.1525684985.git.mchehab+samsung@kernel.org>
References: <cover.1525684985.git.mchehab+samsung@kernel.org><cover.1525684985.git.mchehab+samsung@kernel.org> <cd5b6e6a8d51820ee158127cdd50e44645c44ee7.1525684985.git.mchehab+samsung@kernel.org>
Subject: Re: [PATCH 18/18] w1: w1_io.c: fix a kernel-doc warning
MIME-Version: 1.0
Message-Id: <702861525777419@web22j.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Tue, 08 May 2018 14:03:39 +0300
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

07.05.2018, 12:36, "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>:
> Add a blank line to avoid this Sphinx warning:
>         ./drivers/w1/w1_io.c:197: WARNING: Definition list ends without a blank line; unexpected unindent.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Looks good to me, thank you!
What tree should this be forwarded to, or folks from linux doc will pick it up?

Acked-by: Evgeniy Polyakov <zbr@ioremap.net>

> ---
>  drivers/w1/w1_io.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/w1/w1_io.c b/drivers/w1/w1_io.c
> index 075d120e7b88..0364d3329c52 100644
> --- a/drivers/w1/w1_io.c
> +++ b/drivers/w1/w1_io.c
> @@ -194,6 +194,7 @@ static u8 w1_read_bit(struct w1_master *dev)
>   * bit 0 = id_bit
>   * bit 1 = comp_bit
>   * bit 2 = dir_taken
> + *
>   * If both bits 0 & 1 are set, the search should be restarted.
>   *
>   * Return: bit fields - see above
> --
> 2.17.0
