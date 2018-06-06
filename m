Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 99179601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=juzza.co.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752174AbeFFMTn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:19:43 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:35003 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbeFFMTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:19:40 -0400
Date: Wed, 6 Jun 2018 13:19:25 +0100 (BST)
From: Justin Skists <justin.skists@juzza.co.uk>
To: John Whitmore <johnfwhitmore@gmail.com>,
        linux-kernel@vger.kernel.org
Cc: kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, colin.king@canonical.com,
        tglx@linutronix.de
Message-ID: <1745633200.284162.1528287566017@email.1and1.co.uk>
In-Reply-To: <20180606114003.22654-1-johnfwhitmore@gmail.com>
References: <20180606114003.22654-1-johnfwhitmore@gmail.com>
Subject: Re: staging: rtl8192e: Series of coding style changes
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev28
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:mQgM+IbLC81jENnFMxCmi7ypiWo0CPhk/IiDrP7eQ8dJvypZit5
 FdIM704EsCrMaZ81m/vlnLCsjr5SP1Qsy7g8dbqhOiE103li+/MrqL4SDfYF844RH1p3TEb
 qW8nP0tAYRXmHrviZ/NwDEo8GjHUkwJuRvzR1lLJvgZ00Dl0BH1Co22ZJ7Ok0CuCsCMlTX9
 84QzvEHOGB+wdkL5zawRQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xp+DmS7txxQ=:v/kKmeRkPFBsTZF5Bk4xAi
 mucM4vIidAqOgWG7qXesVnC6Tku0Z/XAqVV4zASgeYUjH2cGpHqc7IlOorAdRdbhzgJudBGoV
 buoODSgjWrB42i86ufaeWhY/xh/u9xfLHe7Bc+cm7WWWdnwE8K617dKfsVoMAzOkqqozk06S2
 jiZOH1LmkUvU7T72G42Ogfvwlmxw7T0mQwuBUhryk2k+i9q7QSnP2eG7I2FlNAdZgIniUz6BQ
 swkzBQqblXRZdgoBkzVwLrc5rBNvpIZloBc0Y8yr8YoULAPfkT0wYb6Y1Z1Uw4skVEEL1710f
 1HjBEzJBGhkaMjmvNaXjSxFgLAZ8reeU7rI6H938RRtz7TwpyM7VxSj0jRy6brGvWt3G05E7I
 ApeOPeh39o8JrXElnbSGXKGQlTqAUOfTY4JvYj/3PHhyYxbnsnjcYLzapxShGCm6h6CxM5Y5n
 ekm2rnXEzKTVHF94oNCwbo+by6sRGjUmTKRVmGa3NASkuqzu0/uIqJdCQ1OQRezjsMyBk2LsG
 kgOFR839cWrVTdFUQIz+uapNxoY1854/orjvMo7ttpvFSJJGV8EjBwS4kCBYs6xOnPARPQqYe
 DShxnN9paCkfo3b7DEXRVn5PiIjsDyJQTz4Jk8WzxyjaetLTrPkq+hXO51vC8/S3K37J/tqG5
 S8peue/upSmyyJQyuynzV4gKHYZvF9wgyyM3SAy/hSKMNxyiK187dm/DeEL+e8UGXfhBofrcj
 tY/QD5SeyvYt/22r
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 06 June 2018 at 12:39 John Whitmore <johnfwhitmore@gmail.com> wrote:

> Again these are just some simple coding style changes to the file, so nothing
> of importance.

If it keeps grumpy maintainers happy, then it's of great importance! :-)


Justin
