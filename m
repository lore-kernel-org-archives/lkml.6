Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965707AbeEYJst (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:48:49 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55149 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965287AbeEYJrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:47:04 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: PM / suspend / s2idle: avoiding splats on RT
Date: Fri, 25 May 2018 11:46:44 +0200
Message-Id: <20180525094648.15464-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch #1 is a repost with the s2idle bits included. I tested via=20
	echo s2idle > mem_sleep && echo mem > state=20

and I woke up the machine via the power on button. Patches #2+ were
additionally required with s2idle.

Sebastian
