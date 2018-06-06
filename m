Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cADmSTZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DAD60607B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752782AbeFFPMc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:12:32 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:44576 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751957AbeFFPMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:12:31 -0400
X-Google-Smtp-Source: ADUXVKJ/i/iTRlkfvUqO8bVufWg2KqpMm/F2rl/qJ3fgaO9DdmbFV1jROwstI887Grhd4R5SwUlvl77JLpw7CFAPx8w=
MIME-Version: 1.0
References: <CAPM=9twnxQsdgF6Rwn7bm=3rnk5+Qyab7pRDk9QuLq0o+f3CTQ@mail.gmail.com>
In-Reply-To: <CAPM=9twnxQsdgF6Rwn7bm=3rnk5+Qyab7pRDk9QuLq0o+f3CTQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 6 Jun 2018 08:12:18 -0700
Message-ID: <CA+55aFycV+aKbfuNN1+z49C5tKJDwdSJVjew7Ri-LndZ5-aFdw@mail.gmail.com>
Subject: Re: [git pull] drm for v4.18-rc1
To: Dave Airlie <airlied@gmail.com>
Cc: DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 8:50 PM Dave Airlie <airlied@gmail.com> wrote:
>
> First up I've moved the drm tree to a new location on freedesktop.org. The main
> reason was to explore using Daniel's maintainer tools (dim-tools) to manage
> pull requests and possibly open the drm to having co-maintainers at the top
> level in the future. If there are any issues in the pull formatting or with the
> hopefully correctly signed tag, let me know.

No problem. As long as I see that it's signed by you, I don't care
where it ends up being.

Everything looked normal.

                  Linus
