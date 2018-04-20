Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753443AbeDTFad convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 01:30:33 -0400
Received: from esa4.barco.c3s2.iphmx.com ([68.232.151.234]:51152 "EHLO
        esa4.barco.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750729AbeDTFac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 01:30:32 -0400
X-IronPort-AV: E=Sophos;i="5.49,300,1520902800";
   d="scan'208";a="8121030"
From: Peter Korsgaard <peter.korsgaard@barco.com>
To: Wolfram Sang <wsa@the-dreams.de>
CC: <linux-i2c@vger.kernel.org>, Peter Rosin <peda@axentia.se>,
        Jonathan Corbet <corbet@lwn.net>, Jean Delvare <jdelvare@suse.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] i2c: i2c-mux-gpio: move header to platform_data
References: <20180419200015.15095-1-wsa@the-dreams.de>
        <20180419200015.15095-3-wsa@the-dreams.de>
Date: Fri, 20 Apr 2018 07:25:37 +0200
In-Reply-To: <20180419200015.15095-3-wsa@the-dreams.de> (Wolfram Sang's
        message of "Thu, 19 Apr 2018 22:00:08 +0200")
Message-ID: <85fu3qzbxq.fsf@lists.barco.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "WS" == Wolfram Sang <wsa@the-dreams.de> writes:

WS> This header only contains platform_data. Move it to the proper directory.
WS> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Thanks,

Acked-by: Peter Korsgaard <peter.korsgaard@barco.com>

--
Bye, Peter Korsgaard
This message is subject to the following terms and conditions: MAIL DISCLAIMER<http://www.barco.com/en/maildisclaimer>
