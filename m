Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932315AbeCLKcB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 06:32:01 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:53468 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751303AbeCLKb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 06:31:59 -0400
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Date: Mon, 12 Mar 2018 10:31:43 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
CC: Kees Cook <keescook@chromium.org>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>, "Takashi Iwai" <tiwai@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-core: Add missing NULL check
Message-ID: <20180312103143.y7bidz4gj6ya7dgo@localhost.localdomain>
References: <20180308200653.GA47801@beast>
 <20180309125050.GD5252@sirena.org.uk>
 <CAGXu5jJo2JVXKV+nieGwzH0XOPpzzo4DmYy0L05iZD6wwO1vGg@mail.gmail.com>
 <20180309202242.GA3073@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180309202242.GA3073@sirena.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=935 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1803120123
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 08:22:42PM +0000, Mark Brown wrote:
> On Fri, Mar 09, 2018 at 10:45:16AM -0800, Kees Cook wrote:
> > On Fri, Mar 9, 2018 at 4:50 AM, Mark Brown <broonie@kernel.org> wrote:
> > > On Thu, Mar 08, 2018 at 12:06:53PM -0800, Kees Cook wrote:
> I think I might just remove the file though, it's been non-functional on
> most systems for a while now as almost all the drivers migrated to
> regmap and nobody complained so we should be safe.  There's still
> something that ought to be investigated here.

Looks like we might already be about to try that since it looks
like the componentisation actually removed these files, although
I assume inadvertently.

Thanks,
Charles
