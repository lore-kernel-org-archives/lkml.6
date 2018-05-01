Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755922AbeEAPd0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 11:33:26 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:45879 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753878AbeEAPdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 11:33:25 -0400
X-Google-Smtp-Source: AB8JxZoWK1LRYMNnobwxKHTBdWW3j/eTHLHzKaij2RA0EWO8BIDIvvCPtLq+Qcoir7QZysSzBtjuqg==
Subject: Re: [PATCH v3 2/2] nvmem: Add RAVE SP EEPROM driver
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Aleksander Morgado <aleksander@aleksander.es>
References: <20180501052952.26765-1-andrew.smirnov@gmail.com>
 <20180501052952.26765-3-andrew.smirnov@gmail.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <e6f74f86-a427-4165-cbc0-27fe129dab8e@linaro.org>
Date: Tue, 1 May 2018 16:33:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180501052952.26765-3-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/05/18 06:29, Andrey Smirnov wrote:
> +// SPDX-License-Identifier: GPL-2.0+
...
> +MODULE_LICENSE("GPL");
I think this should be
MODULE_LICENSE("GPL v2");

--srini
