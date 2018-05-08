Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754121AbeEHDW1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 23:22:27 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:51842 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753526AbeEHDW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 23:22:26 -0400
Date: Mon, 07 May 2018 23:22:24 -0400 (EDT)
Message-Id: <20180507.232224.1710068197351359395.davem@davemloft.net>
To: anders.roxell@linaro.org
Cc: shuah@kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: net: add udpgso* to TEST_GEN_FILES
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180504091725.24977-1-anders.roxell@linaro.org>
References: <20180504091725.24977-1-anders.roxell@linaro.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anders Roxell <anders.roxell@linaro.org>
Date: Fri,  4 May 2018 11:17:25 +0200

> The generated files udpgso* shouldn't be part of TEST_PROGS, they are
> used by udpgso.sh and udpgsp_bench.sh. They should be added to the
> TEST_GEN_FILES to get installed without being added to the main
> run_kselftest.sh script.
> 
> Fixes: 3a687bef148d ("selftests: udp gso benchmark")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Applied, thanks.
