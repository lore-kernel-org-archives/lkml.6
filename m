Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754234AbeEaJU5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 05:20:57 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37126 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754118AbeEaJUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 05:20:52 -0400
X-Google-Smtp-Source: ADUXVKL4q6Jo9gFscUEzipiuSHxvJT9UzL7Jxz+sqpLqiiSbiW+qNT+ddTHVW3UXK7xFuQt7Xc7K8A==
Subject: Re: [PATCH] usb: chipidea: Fix ULPI on imx51
To: Andrey Smirnov <andrew.smirnov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Chen <peter.chen@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>, Chris Healy <cphealy@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20180530173414.6121-1-andrew.smirnov@gmail.com>
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Message-ID: <49e934d8-228a-35b1-8db2-0402422916fa@cogentembedded.com>
Date: Thu, 31 May 2018 12:20:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180530173414.6121-1-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Workaround introduced for i.MX53 in be9cae2479f48 ("usb: chipidea:
> imx: Fix ULPI on imx53") seems to be applicable in case of i.MX51 as
> well. Running latest kernel on ZII RDU1 Board (imx51-zii-rdu1.dts)
> exhibits a kernel frozen on PORTSC access and applying the workaround
> resolves the issue.

Confirmed on 8.9'' RDU1

Tested-By: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
