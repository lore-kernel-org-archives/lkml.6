Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753368AbeENMlq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:41:46 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:36116 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752776AbeENMlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:41:42 -0400
X-Google-Smtp-Source: AB8JxZpohvl0fizYAWN/kH0gVFn/VOlM6BZNS7xzflMic+A5N/w1fJAF5jw3NmYO7qkMGb0XjOlvUqRInPXykt9CRtM=
MIME-Version: 1.0
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Mon, 14 May 2018 18:11:41 +0530
Message-ID: <CAHhAz+itiVWKN7aiCJX17_6iHbyzdr2_4hr8=PB-=gCyzxMthg@mail.gmail.com>
Subject: sound: aplay\arecord audio frame flow
To: alsa-devel <alsa-devel@alsa-project.org>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4ECfpBg024840

[ Please keep me in CC as I'm not subscribed to the list]

Hi All,

Is there anyway in the kernel sound subsystem to know when the
application calls ‘aplay’ and anything starts playing?

Also for arecord\aplay, Is there any way from kernel's point of view
to know when it receives for example the first and last audio frames?


-- 
Thanks,
Sekhar
