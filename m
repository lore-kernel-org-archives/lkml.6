Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751727AbeCTHZ0 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 03:25:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751656AbeCTHZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 03:25:24 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E41232178C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Ryder Lee <ryder.lee@mediatek.com>,
        Stephen Boyd <sboyd@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <75e15960cb001e5fc04c1d5157848e5c524bf963.1521514928.git.ryder.lee@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Garlic Tseng <garlic.tseng@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
References: <004f07aef08148321c320ea09f8169982f73dd2b.1521514928.git.ryder.lee@mediatek.com>
 <75e15960cb001e5fc04c1d5157848e5c524bf963.1521514928.git.ryder.lee@mediatek.com>
Message-ID: <152153072337.254778.2137352951861299387@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] clk: mediatek: add audsys support for MT2701
Date: Tue, 20 Mar 2018 00:25:23 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ryder Lee (2018-03-19 20:16:52)
> Add clock driver support for MT2701 audsys.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---

Applied to clk-next
