Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752836AbeBIVHh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 16:07:37 -0500
Received: from mail-ot0-f173.google.com ([74.125.82.173]:40024 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbeBIVHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 16:07:36 -0500
X-Google-Smtp-Source: AH8x224SoAMB3mAiPwuvWLg/9KRDdQ78a2OQZ0y0LdJB/j8Iipb/NzQ7QxAvHILW4DJF0TaTiY/mpQ==
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Jeremy Cline <jcline@redhat.com>, Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>
From: Laura Abbott <labbott@redhat.com>
Subject: New project: get_maintainer.pl web app
Message-ID: <8089f485-a0f6-aa5f-ad19-16b69eb07f46@redhat.com>
Date: Fri, 9 Feb 2018 13:07:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

get_maintainers.pl has been the standard script for figuring out where to
send patches or bug reports. It has the disadvantage of requiring a kernel
tree to actually run though, which makes it harder for bug reports to
came in. I've started working on a small project to expose get_maintainers.pl
as a web app. This would let users enter information from a patch or crash
and call out to get_maintainers.pl. The current project just lets users
enter in a file path and it displays the output as is. There's lots of options
for what we could do with the output (omitting e-mails for those maintainers
who don't want to participate, printing out more helpful warnings etc.)

The project is at https://pagure.io/get_maintainers and is not even close
to ready for primetime (passing data to get_maintainer.pl almost certainly
needs more thought). I'm mostly interested if anyone else would find this
useful or has general feedback.

Thanks,
Laura
