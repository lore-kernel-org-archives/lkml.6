Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752727AbeEOVLk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 17:11:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752354AbeEOVLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 17:11:38 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Akshu Agrawal <akshu.agrawal@amd.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1525859941-23654-2-git-send-email-akshu.agrawal@amd.com>
Cc: djkurtz@chromium.org, akshu.agrawal@amd.com, Alexander.Deucher@amd.com,
        mturquette@baylibre.com, christian.koenig@amd.com, airlied@redhat.com,
        Shaoyun.Liu@amd.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        linux-acpi@vger.kernel.org
References: <1525859941-23654-1-git-send-email-akshu.agrawal@amd.com>
 <1525859941-23654-2-git-send-email-akshu.agrawal@amd.com>
Message-ID: <152641869759.237094.11560670016483664442@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 1/2] clk: x86: Add ST oscout platform clock
Date: Tue, 15 May 2018 14:11:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4FLBk0p025300

Quoting Akshu Agrawal (2018-05-09 02:59:00)
> Stoney SoC provides oscout clock. This clock can support 25Mhz and
> 48Mhz of frequency.
> The clock is available for general system use.
> 
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
