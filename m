Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756881AbeEJKho (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 06:37:44 -0400
Received: from forward1o.cmail.yandex.net ([37.9.109.84]:44562 "EHLO
        forward1o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756729AbeEJKhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 06:37:43 -0400
Authentication-Results: mxback10j.mail.yandex.net; dkim=pass header.i=@yandex.ru
From: Evgeniy Polyakov <zbr@ioremap.net>
Envelope-From: drustafa@yandex.ru
To: Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20180509071132.069a5d5d@lwn.net>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
        <cover.1525684985.git.mchehab+samsung@kernel.org>
        <cd5b6e6a8d51820ee158127cdd50e44645c44ee7.1525684985.git.mchehab+samsung@kernel.org>
        <702861525777419@web22j.yandex.ru>
        <20180509093218.5e566439@vento.lan> <20180509071132.069a5d5d@lwn.net>
Subject: Re: [PATCH 18/18] w1: w1_io.c: fix a kernel-doc warning
MIME-Version: 1.0
Message-Id: <351071525948659@web4o.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Thu, 10 May 2018 13:37:39 +0300
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

09.05.2018, 16:11, "Jonathan Corbet" <corbet@lwn.net>:
> On Wed, 9 May 2018 09:32:18 -0300
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
>
>>  > Looks good to me, thank you!
>>  > What tree should this be forwarded to, or folks from linux doc will pick it up?
>>  >
>>  > Acked-by: Evgeniy Polyakov <zbr@ioremap.net>
>>
>>  Jon prefers if this could go via the usual maintainer's tree.
>>
>>  So, could you send it via yours?
>
> With the ack I can pick it up, no worries. I somehow missed this when I
> went through the set.

Great, thank you!
Let me know if you want me to push it upstream via my tree.
