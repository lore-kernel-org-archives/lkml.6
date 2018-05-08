Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754156AbeEHD3E (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 23:29:04 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:51886 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753824AbeEHD3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 23:29:03 -0400
Date: Mon, 07 May 2018 23:29:01 -0400 (EDT)
Message-Id: <20180507.232901.1578185927050716610.davem@davemloft.net>
To: anders.roxell@linaro.org
Cc: shuah@kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: net: use TEST_PROGS_EXTENDED
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180504164725.13516-1-anders.roxell@linaro.org>
References: <20180504164725.13516-1-anders.roxell@linaro.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anders Roxell <anders.roxell@linaro.org>
Date: Fri,  4 May 2018 18:47:25 +0200

> When a script file that isn't generated uses the variable
> TEST_GEN_PROGS_EXTENDED and a 'make -C tools/testing/selftests clean' is
> performed the script file gets removed and git shows the file as
> deleted. For script files that isn't generated TEST_PROGS_EXTENDED
> should be used.
> 
> Fixes: 9faedd643fd9 ("selftests: net: add in_netns.sh TEST_GEN_PROGS_EXTENDED")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Applied.
