Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426173AbeBOQjT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:39:19 -0500
Received: from resqmta-ch2-07v.sys.comcast.net ([69.252.207.39]:46668 "EHLO
        resqmta-ch2-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1423532AbeBOQjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:39:15 -0500
Date: Thu, 15 Feb 2018 10:39:13 -0600 (CST)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Dennis Zhou <dennisszhou@gmail.com>
cc: Tejun Heo <tj@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] percpu: match chunk allocator declarations with
 definitions
In-Reply-To: <3865d86559d8499f9bbb12f578bf9e6aa8f8882e.1518668149.git.dennisszhou@gmail.com>
Message-ID: <alpine.DEB.2.20.1802151038510.2970@nuc-kabylake>
References: <cover.1518668149.git.dennisszhou@gmail.com> <3865d86559d8499f9bbb12f578bf9e6aa8f8882e.1518668149.git.dennisszhou@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfN87+XIWdx7HFyxt+5frj27BOX5u1yIIP0sAYZDZ92UiFWFyf8KtQhW914ZxbQc0lEiPGhBP0bVzAW+fIIz+FKABd2Ik1nuhSFfBvY8bbq24NsKQi9lm
 0c/lMqS2InuX/extLhIKHbdTs5zEvYdZKSloXPi9L9bkWZtVwEUMZwZyYNxvLsNb6oVh8IG+9zwLfsFT06j2Xukdjn/MrQr960YAfz3gYbdaKuL2zpgM51+E
 l+bIVagYbTc8b7AG4lo3mq1fA8c2k3kDs6nvKTGRNsWBwGcOLjCgYvwe6F5Yy6Od
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Feb 2018, Dennis Zhou wrote:

> At some point the function declaration parameters got out of sync with
> the function definitions in percpu-vm.c and percpu-km.c. This patch
> makes them match again.

Acked-by: Christoph Lameter <cl@linux.com>
