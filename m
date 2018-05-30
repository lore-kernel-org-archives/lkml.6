Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753299AbeE3LoH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:44:07 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46742 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752102AbeE3LoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:44:03 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ramesh Thomas <ramesh.thomas@intel.com>
Subject: [PATCH 0/2] cpuidle: governors: Cleanups related to PM QoS
Date: Wed, 30 May 2018 13:40:13 +0200
Message-ID: <2261593.SGWtJkXgY3@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

These patches clean up a couple of things related to PM QoS in cpuidle
governors.  Please refer to the changelogs for details.

Thanks,
Rafael
