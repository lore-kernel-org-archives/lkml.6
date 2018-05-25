Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965666AbeEYKUW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:20:22 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55294 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936154AbeEYKUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:20:06 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, bigeasy@linutronix.de
Subject: SRCU: add a static initializer and let cpufreq use it
Date: Fri, 25 May 2018 12:19:56 +0200
Message-Id: <20180525101958.13277-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpufreq would benefit from a static initializer which avoids an initcall
and bug fixing in case the warning (notifier used before initialized)
has been triggered.

Sebastian
