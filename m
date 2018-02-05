Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752015AbeBEWW1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 17:22:27 -0500
Received: from relay1.sgi.com ([192.48.180.66]:55573 "EHLO relay.sgi.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751175AbeBEWWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 17:22:15 -0500
Message-Id: <20180205221503.032756454@stormcage.americas.sgi.com>
User-Agent: quilt/0.46-1
Date: Mon, 05 Feb 2018 16:15:03 -0600
From: <mike.travis@hpe.com>
To: Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, Andrew Banman <andrew.banman@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] x86/platform/UV: Fix GAM Range Table entries less than 1GB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Fix GAM Range Table address ranges less than 1GB.

-- 
