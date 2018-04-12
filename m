Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753061AbeDLST7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 14:19:59 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:40147 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752700AbeDLST5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 14:19:57 -0400
X-Google-Smtp-Source: AIpwx49QxGdE1D7h5z+McHyH0/RaoD+SYWivXXzLuX+2qU/cla0efOfFv6N0Yo9M9yKWa0jUtjCtuMzT6Xt9uJm/Nq4=
MIME-Version: 1.0
In-Reply-To: <0ab8f251-0df3-558c-6c27-9c1a813dcfd4@Netapp.com>
References: <176ac3d9-dc2a-0a90-b41a-eb8b5cf006f5@gmail.com> <0ab8f251-0df3-558c-6c27-9c1a813dcfd4@Netapp.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 12 Apr 2018 11:19:56 -0700
X-Google-Sender-Auth: t6yCAeiwF0bZpa_jws-UaZ1lAN8
Message-ID: <CA+55aFzmAR+csQxR-M=MZhUd=1XqOjOcmPWjq_5iGcW_r7YDXA@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull NFS client updates for 4.17
To: Anna Schumaker <Anna.Schumaker@netapp.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 11:13 AM, Anna Schumaker
<Anna.Schumaker@netapp.com> wrote:
> Hi Linus,
>
> What's the status of this?  I don't see the NFS changes in your tree yet, and I'm worried the pull request email got lost somewhere along the way.

No, it's still in my queue. I do my pulls in batches of mostly similar
stuff, and the nfs pull just came in after I had done my last batch of
FS pulls, so now it's waiting for the next one.

Which will be later today. In fact, I think I'm done with the "fixes"
batch, and filesystems may be next.

                  Linus
