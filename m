Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeEEDLE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 23:11:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:45746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751751AbeEEDLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 23:11:03 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Akshu Agrawal <akshu.agrawal@amd.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1525453639-30575-2-git-send-email-akshu.agrawal@amd.com>
Cc: djkurtz@chromium.org, akshu.agrawal@amd.com, Alexander.Deucher@amd.com,
        mturquette@baylibre.com, christian.koenig@amd.com, airlied@redhat.com,
        Shaoyun.Liu@amd.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        linux-acpi@vger.kernel.org
References: <1525453639-30575-1-git-send-email-akshu.agrawal@amd.com>
 <1525453639-30575-2-git-send-email-akshu.agrawal@amd.com>
Message-ID: <152548986202.138124.14463361929719361009@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 1/2] clk: x86: Add ST oscout platform clock
Date: Fri, 04 May 2018 20:11:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w453BAPv003042

Quoting Akshu Agrawal (2018-05-04 10:07:18)
> Stoney SoC provides oscout clock. This clock can support 25Mhz and
> 48Mhz of frequency.
> The clock is available for general system use.
> 
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> ---
> v2: config change, added SPDX tag and used clk_hw_register_.
> v3: Fix kbuild warning for checking of NULL pointer

I replied on some older patch. Same comments apply still.
