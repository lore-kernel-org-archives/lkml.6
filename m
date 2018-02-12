Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932293AbeBLAgO (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 19:36:14 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181]:43496 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932108AbeBLAgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 19:36:12 -0500
X-Google-Smtp-Source: AH8x225ddqk5EYmNn/B2UVAEUKPjBvQqiNmsB9XooocQTGPeckPmuhOveq6QyAfqZA7JkMkTla9lR052e6bXfGYMn4w=
MIME-Version: 1.0
In-Reply-To: <20180211194154.GB22869@wunner.de>
References: <cover.1518338788.git.lukas@wunner.de> <CAHbf0-Fhi9j5H7VTxF84SENQph+UQE2zRbi2Q-u_DAMh6x+eSg@mail.gmail.com>
 <20180211192314.GA22869@wunner.de> <20180211194154.GB22869@wunner.de>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Mon, 12 Feb 2018 00:35:51 +0000
Message-ID: <CAHbf0-HSNJmXs_Nm+bbcfUifoLEpFsMSpM96a-pVfLFMNz3GFw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Fix deadlock on runtime suspend in DRM drivers
To: Lukas Wunner <lukas@wunner.de>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Dave Airlie <airlied@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Ismo Toijala <ismo.toijala@gmail.com>, nouveau@lists.freedesktop.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>,
        Hans de Goede <hdegoede@redhat.com>, Peter Wu <peter@lekensteyn.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I've not been able to reproduce the original problem you're trying to
solve on amdgpu thats with or without your patch set and the above
"trigger" too

Is anything else required to trigger it, I started multiple DRI_PRIME
glxgears, in parallel, serial waiting the 12 seconds and serial within
the 12 seconds and I couldn't reproduce it

Regards

Mike
