Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427241AbeBORVT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 12:21:19 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:54901 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422692AbeBORVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 12:21:16 -0500
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, rostedt@goodmis.org, tglx@linutronix.de
Subject: Consolidate tasklet + tasklet-hi code
Date: Thu, 15 Feb 2018 18:20:40 +0100
Message-Id: <20180215172042.31573-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo made a RT patch a few years back called "tasklet: Prevent tasklets
from going into infinite spin in RT" [0]. I ripped the non-RT pieces out
of it and here they are. I kept him as the original Author.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/t=
ree/patches/tasklet-rt-prevent-tasklets-from-going-into-infinite-spin-in-rt=
.patch?h=3Dlinux-4.14.y-rt-patches

Sebastian
