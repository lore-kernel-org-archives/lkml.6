Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752393AbeERRt7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 13:49:59 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40555 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751452AbeERRt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 13:49:56 -0400
X-Google-Smtp-Source: AB8JxZqKXo4TmI4y6RjNwEJ9wHmfIW3+5GXaDzU3XL0MswNUX/d66F+sVcecYBkhE1V9jdcUz7Purw==
Date: Fri, 18 May 2018 10:49:54 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] PM / devfreq: Fix handling of min/max_freq == 0
Message-ID: <20180518174954.GC29467@google.com>
References: <CGME20180517223318epcas3p2c4bf4ef6d2c1c4b097df92c309adafa6@epcas3p2.samsung.com>
 <20180517223255.211918-1-mka@chromium.org>
 <5AFE0FFB.6050408@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5AFE0FFB.6050408@samsung.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 08:27:55AM +0900, Chanwoo Choi wrote:
> Hi,
> 
> Please resend the patch with related other patches.
> It is hard to check the dependency/sequence of your patches.

The three patches (excluding the RFC) I sent in the past days are
independent from each other and can be applied individually in no
particular order.

I encountered and fixed the issues one after another, when I sent the
first or second patch I didn't know there would be another
one. Anyway, I'll resend as a series together with other patches,
unless some of the patches get applied before.

Thanks

Matthias
