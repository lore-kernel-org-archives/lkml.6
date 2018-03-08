Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935952AbeCHSMx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 13:12:53 -0500
Received: from resqmta-ch2-07v.sys.comcast.net ([69.252.207.39]:55360 "EHLO
        resqmta-ch2-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932177AbeCHSMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 13:12:52 -0500
Date: Thu, 8 Mar 2018 12:12:50 -0600 (CST)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Chintan Pandya <cpandya@codeaurora.org>
cc: penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] slub: use jitter-free reference while printing age
In-Reply-To: <1520492010-19389-1-git-send-email-cpandya@codeaurora.org>
Message-ID: <alpine.DEB.2.20.1803081211230.14668@nuc-kabylake>
References: <1520492010-19389-1-git-send-email-cpandya@codeaurora.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfOc8GG1wz7Fb0QlqA2e5GmNZbKUBZP2fsUitNCmE4NHBJRifJOkLYPZ+jNQVLeKqifS8Usi8pAk/hgxfTGDZhqb8ilp5HAxIYjUXK2ykzLHXk8FkV3fo
 hftWL5ttwHvSvenXAFLZT496BUNBRJS0Bf1qwJDKEtSi9IUFxZyZY8kR8qYNEAxuSfCzI9+hZ3WTUMvnKxBttHt+CIyWGhuVhV8/UuCjTmpqKUlcfHiA3LGK
 6Fngn/dYyiDEXLbbbIADmGuSAlmsLxgulHGF4ikidJGBqnKebx6oz8K/PMnfrgr7l0I50JmHK6AHDEtP7UB6aABsT5CehDaQuL6eijVUKw/SniUY4tEdS+Ak
 UOq0PyK0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Mar 2018, Chintan Pandya wrote:

> In this case, object got freed later but 'age'
> shows otherwise. This could be because, while
> printing this info, we print allocation traces
> first and free traces thereafter. In between,
> if we get schedule out or jiffies increment,
> (jiffies - t->when) could become meaningless.

Could you show the new output style too?

Acked-by: Christoph Lameter <cl@linux.com>
