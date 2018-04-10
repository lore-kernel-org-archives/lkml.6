Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752200AbeDJSUw convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 14:20:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751624AbeDJSUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 14:20:50 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5404421738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <b70afd25fc48ad4d677e4e53951f2138cd34b85e.1523351100.git.viresh.kumar@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <b70afd25fc48ad4d677e4e53951f2138cd34b85e.1523351100.git.viresh.kumar@linaro.org>
Message-ID: <152338444966.180276.17472609064497290233@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] of: Don't create platform device for OPP tables
Date: Tue, 10 Apr 2018 11:20:49 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Viresh Kumar (2018-04-10 02:05:22)
> The OPP tables are present as separate nodes, whose phandle is used in
> the "operating-points-v2" property of devices. Currently the OF core
> creates a platform device for the OPP table unconditionally, which is
> not used by any kernel code.
> 
> Skip creating OPP table platform devices.
> 
> Reported-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
