Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeDYVDm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 17:03:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48658 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751451AbeDYVDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 17:03:39 -0400
Date: Wed, 25 Apr 2018 17:03:12 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: kvm@vger.kernel.org, alex.williamson@redhat.com, kwankhede@nvidia.com,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] sample: vfio mdev display - guest driver
Message-ID: <20180425210312.GE6376@char.us.oracle.com>
References: <20180409103513.8020-1-kraxel@redhat.com>
 <20180409103513.8020-3-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409103513.8020-3-kraxel@redhat.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8874 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=721
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804250192
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> new file mode 100644
> index 0000000000..0ebd8feead
> --- /dev/null
> +++ b/samples/vfio-mdev/mdpy-fb.c
> @@ -0,0 +1,232 @@
> +/*
> + * Framebuffer driver for mdpy (mediated virtual pci display device).
> + *
> + * See mdpy-defs.h for device specs
> + *
> + *   (c) Gerd Hoffmann <kraxel@redhat.com>

Year?
