Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753442AbeEURmp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 13:42:45 -0400
Received: from muru.com ([72.249.23.125]:43864 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753323AbeEURlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 13:41:19 -0400
Date: Mon, 21 May 2018 10:41:16 -0700
From: Tony Lindgren <tony@atomide.com>
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 02/33] mfd: omap-usb-host: use match_string() helper
Message-ID: <20180521174116.GB98604@atomide.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
 <1526903890-35761-3-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526903890-35761-3-git-send-email-xieyisheng1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Yisheng Xie <xieyisheng1@huawei.com> [180521 12:11]:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.

Looks OK to me:

Acked-by: Tony Lindgren <tony@atomide.com>
