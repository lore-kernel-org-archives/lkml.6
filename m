Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbeCYTdw (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 15:33:52 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37633 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750782AbeCYTds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 15:33:48 -0400
X-Google-Smtp-Source: AG47ELuAPIprRKxNfuctMcSmrEZSTMSnYPmG4QNzKUY5cGGdSn6HzdGUgZYCLTB3Seqo+FpMid5diw==
From: Craig Tatlor <ctatlor97@gmail.com>
To: robh@kernel.org, viresh.kumar@linaro.org, mark.rutland@arm.com,
        mturquette@baylibre.com, sboyd@codeaurora.org, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux@arm.linux.org.uk
Subject: Re: [v9,04/15] clk: qcom: Add HFPLL driver
Date: Sun, 25 Mar 2018 20:33:41 +0100
Message-Id: <20180325193341.27845-1-ctatlor97@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <520347148-27852-5-git-send-email-sricharan@codeaurora.org>
References: <520347148-27852-5-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This doesn't seem to work correctly with the higher clocks on 8974pro, specifically 2150400000 hz or above, maybe its something to do with being bigger than an unsigned long.

When i try to set any higher frequency it jumps down to 300mhz.
