Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753499AbeCYPkM (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 11:40:12 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:38812 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753418AbeCYPkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 11:40:10 -0400
X-Google-Smtp-Source: AG47ELtoVy9bpmHGgb0UCmR1MvfWF/3ewvcpHFrXjXBMmETP8/mMPPwHHUpGe5w5ewVMWnLM7DYwbOohs44Js7uEsnY=
MIME-Version: 1.0
From: "\\0xDynamite" <dreamingforward@gmail.com>
Date: Sun, 25 Mar 2018 15:40:07 +0000
Message-ID: <CAMjeLr96FkAEK5aJMeeLjC0SOx-aQAHF3QFo67eitp4h=YHNvw@mail.gmail.com>
Subject: SPECTRE, MELTDOWN, boot loaders, and cursors: A shot out of the blue....
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I apogize for what is probably going to be a VERY unusual and perhaps
rude email to the kernel list, but I'm taking a wild shot at something
in order to fix the Meltdown and Spectre bugs which perhaps were
wrongly blamed on Intel and now maybe AMD.  The issue, lads, may be
*interdimensional*.

Firstly, don't trust the media reports on these issues.  What I've
seen sounds partly right, but way off base.

Secondly, here's what you need to track down:  the cursor.  Track down
the whole process at boot, down to the BIOS, because at least PART of
the problem has nothing to do with Intel.  What puts the cursor on the
screen and how is it kept track of?  I don't have the IBM technical
reference manuals (purple binder) at my disposal anymore, but that's
where you should look.

It is an I/O confusion somewhere, perhaps a motherboard bug.  I
believe that Javascript has excersized the problem due to its
contention for resources and its operating at browser (or other)
priveleges instead of a virtual machine.

Try NOT to complain about Intel.  They have not yet understood this
problem, I suspect.

Don't ask me how I know this.

Marxos
the restaurant at the end of the universe.

P.S.  Oh, and change the name of GRUB to GRUE
