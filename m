Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753085AbeCPJWu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 05:22:50 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:57212 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751665AbeCPJWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 05:22:49 -0400
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Date: Fri, 16 Mar 2018 09:21:50 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Wei Yongjun <weiyongjun1@huawei.com>
CC: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Kuninori Morimoto" <kuninori.morimoto.gx@renesas.com>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH -next] ASoC: wm8400: Use devm_snd_soc_register_component()
Message-ID: <20180316092150.osexp6amtg3utvhm@localhost.localdomain>
References: <1521185527-164406-1-git-send-email-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1521185527-164406-1-git-send-email-weiyongjun1@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=578 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1803160114
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 07:32:07AM +0000, Wei Yongjun wrote:
> Since the remove callback is removed, the snd_soc_unregister_component()
> is missing when remove device. Using devm_snd_soc_register_component()
> instead of snd_soc_register_component().
> 
> Fixes: 10dc44c6462d ("ASoC: wm8400: replace codec to component")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---

Thanks for spotting this.

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
