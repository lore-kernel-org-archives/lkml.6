Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752150AbeEOVxZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 17:53:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750748AbeEOVxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 17:53:23 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Dinh Nguyen <dinguyen@kernel.org>, linux-clk@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1525271313-24427-2-git-send-email-dinguyen@kernel.org>
Cc: dinguyen@kernel.org, mturquette@baylibre.com,
        linux-kernel@vger.kernel.org
References: <1525271313-24427-1-git-send-email-dinguyen@kernel.org>
 <1525271313-24427-2-git-send-email-dinguyen@kernel.org>
Message-ID: <152642120192.237094.12936695477697525600@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] clk: socfpga: stratix10: suppress unbinding platform's clock
 driver
Date: Tue, 15 May 2018 14:53:21 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4FLrTA8029051

Quoting Dinh Nguyen (2018-05-02 07:28:33)
> The Stratix10 clock driver is essential to system operation, so their
> removal should never happen.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---

Applied to clk-next
