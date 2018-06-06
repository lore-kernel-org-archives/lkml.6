Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20150623.gappssmtp.com header.i=@fooishbar-org.20150623.gappssmtp.com header.b="p0iCcH8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B65C760767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932285AbeFFP0g (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:26:36 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:40361 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752643AbeFFP00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:26:26 -0400
X-Google-Smtp-Source: ADUXVKJvezQdhT7hoib7LX77i6LED00KQxTNOKeW3T3cxVBkuBdJZh5zh+pVnqhAT7f29P/wwRHfk1uUfsljdJqwBcY=
MIME-Version: 1.0
In-Reply-To: <CAPM=9twnxQsdgF6Rwn7bm=3rnk5+Qyab7pRDk9QuLq0o+f3CTQ@mail.gmail.com>
References: <CAPM=9twnxQsdgF6Rwn7bm=3rnk5+Qyab7pRDk9QuLq0o+f3CTQ@mail.gmail.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 6 Jun 2018 16:26:23 +0100
Message-ID: <CAPj87rPDO+M46mON6hP9YxAg81ATcaT3ZdLaHe99AVgrPZwjiQ@mail.gmail.com>
Subject: Re: [git pull] drm for v4.18-rc1
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6 June 2018 at 04:50, Dave Airlie <airlied@gmail.com> wrote:
> First up I've moved the drm tree to a new location on freedesktop.org. The main
> reason was to explore using Daniel's maintainer tools (dim-tools) to manage
> pull requests and possibly open the drm to having co-maintainers at the top
> level in the future. If there are any issues in the pull formatting or with the
> hopefully correctly signed tag, let me know.
>
> This location also might change again as there is an fd.o migration to
> using gitlab
> based hosting for git trees, need to talk to fd.o admins about what might happen
> there.

anongit isn't going away for the foreseeable future (probably ever,
given the number of Yocto BSPs which will be around forever), so that
repo will continue to stay. When that repo gets migrated, the option
to clone via HTTPS direct to gitlab will be added, but anongit will
remain as a pushed mirror. For most of our projects this is a win, but
given you use signed tags it won't make a difference really.

Cheers,
Daniel
