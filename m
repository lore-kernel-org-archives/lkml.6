Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753058AbeDCTA0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 15:00:26 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:53803 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752132AbeDCTAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 15:00:25 -0400
X-Google-Smtp-Source: AIpwx483bRm82G2pmxTq3B5F+NBrJzHXxerrsRJZizPAk+7IxXIatztxWB0Opc2Ov9mI3XD5cb9QHV55RgDTa/m+SNM=
MIME-Version: 1.0
In-Reply-To: <20180402163413.GV29239@sirena.org.uk>
References: <20180402163413.GV29239@sirena.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Apr 2018 12:00:24 -0700
X-Google-Sender-Auth: UpU6hddqxbR-aFLLoawGrACD6UU
Message-ID: <CA+55aFwXUh6AkFoYN4DihjaYwNjD-ti=hw5jz6f-bhjXYS+dNQ@mail.gmail.com>
Subject: Re: [GIT PULL] regulator updates for v4.17
To: Mark Brown <broonie@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 2, 2018 at 9:34 AM, Mark Brown <broonie@kernel.org> wrote:
>
> A very small set of updates for the regulator API this time around,
> there's a few bug fixes and also:

Heh. This one was "very small", and the regmap update was "fairly large".

I think the regmap one was smaller. This one actually has a new
driver, the regmap one looked like mostly cleanups.

But I've used your words for the commit logs.

               Linus
