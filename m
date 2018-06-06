Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PeTMhAsG"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C2D2A60764
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752384AbeFFPIZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:08:25 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51785 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752006AbeFFPIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:08:21 -0400
X-Google-Smtp-Source: ADUXVKKsP/LM6i4Biqjhc0UzB9WNeizbkcm582O/9bkpBJIvmUEx6h4pcC9JhF1pw9GGuQPm+aLUbQ==
From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v4 1/7] interconnect: Add generic on-chip interconnect API
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>,
        gregkh@linuxfoundation.org, Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Saravana Kannan <skannan@codeaurora.org>,
        seansw@qti.qualcomm.com, khilman@baylibre.com,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, davidai@quicinc.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        lakml <linux-arm-kernel@lists.infradead.org>
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
 <20180309210958.16672-2-georgi.djakov@linaro.org>
 <CAHLCerNmBAbu4UcQ+uksXN8z-o-kxLct9ryfy5qBY0Z2jDNRGg@mail.gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <3f0e5606-c28d-6bd9-387e-23be1d0185fc@linaro.org>
Date: Wed, 6 Jun 2018 18:08:19 +0300
MIME-Version: 1.0
In-Reply-To: <CAHLCerNmBAbu4UcQ+uksXN8z-o-kxLct9ryfy5qBY0Z2jDNRGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

On 25.05.18 г. 11:26, Amit Kucheria wrote:
> On Fri, Mar 9, 2018 at 11:09 PM, Georgi Djakov <georgi.djakov@linaro.org> wrote:
>> This patch introduce a new API to get requirements and configure the
>> interconnect buses across the entire chipset to fit with the current
>> demand.
>>
>> The API is using a consumer/provider-based model, where the providers are
>> the interconnect buses and the consumers could be various drivers.
>> The consumers request interconnect resources (path) between endpoints and
>> set the desired constraints on this data flow path. The providers receive
>> requests from consumers and aggregate these requests for all master-slave
>> pairs on that path. Then the providers configure each participating in the
>> topology node according to the requested data flow path, physical links and
>> constraints. The topology could be complicated and multi-tiered and is SoC
>> specific.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
[..]

>> +Interconnect consumers
>> +----------------------
>> +
>> +Interconnect consumers are the clients which use the interconnect APIs to
>> +get paths between endpoints and set their bandwidth/latency/QoS requirements
>> +for these interconnect paths.
>> +
> 
> This document is missing a section on the locking semantics of the
> framework. Does the core ensure that the entire path is locked for
> set() to propagate?

Yes, the core will ensure that the path is locked. Will add this to the
function description.

[..]

>> +
>> +static int path_init(struct icc_path *path)
>> +{
>> +       struct icc_node *node;
>> +       size_t i;
>> +
>> +       for (i = 0; i < path->num_nodes; i++) {
>> +               node = path->reqs[i].node;
>> +
>> +               mutex_lock(&node->provider->lock);
>> +               node->provider->users++;
>> +               mutex_unlock(&node->provider->lock);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
> 
> Consider adding some comments for node_aggregate and
> provider_aggregate's aggregation algorithm
> 
> "We want the path to honor all bandwidth requests, so the average
> bandwidth requirements from each consumer are aggregated at each node
> and provider level. The peak bandwidth requirements will then be the
> highest of all the peak bw requests"
> 
> or something to the effect that.

Ok, thanks.

>> +static void node_aggregate(struct icc_node *node)
>> +{
>> +       struct icc_req *r;
>> +       u32 agg_avg = 0;
>> +       u32 agg_peak = 0;
>> +
>> +       hlist_for_each_entry(r, &node->req_list, req_node) {
>> +               /* sum(averages) and max(peaks) */
>> +               agg_avg += r->avg_bw;
>> +               agg_peak = max(agg_peak, r->peak_bw);
>> +       }
>> +
>> +       node->avg_bw = agg_avg;
>> +       node->peak_bw = agg_peak;
>> +}
>> +
>> +static void provider_aggregate(struct icc_provider *provider, u32 *avg_bw,
>> +                              u32 *peak_bw)
>> +{
>> +       struct icc_node *n;
>> +       u32 agg_avg = 0;
>> +       u32 agg_peak = 0;
>> +
>> +       /* aggregate for the interconnect provider */
> 
> You could get rid of this, the function name says as much.

Ok.

>> +       list_for_each_entry(n, &provider->nodes, node_list) {
>> +               /* sum the average and max the peak */
>> +               agg_avg += n->avg_bw;
>> +               agg_peak = max(agg_peak, n->peak_bw);
>> +       }
>> +
>> +       *avg_bw = agg_avg;
>> +       *peak_bw = agg_peak;
>> +}
>> +
>> +static int constraints_apply(struct icc_path *path)
>> +{
>> +       struct icc_node *next, *prev = NULL;
>> +       int i;
>> +
>> +       for (i = 0; i < path->num_nodes; i++, prev = next) {
>> +               struct icc_provider *provider;
>> +               u32 avg_bw = 0;
>> +               u32 peak_bw = 0;
>> +               int ret;
>> +
>> +               next = path->reqs[i].node;
>> +               /*
>> +                * Both endpoints should be valid master-slave pairs of the
>> +                * same interconnect provider that will be configured.
>> +                */
>> +               if (!next || !prev)
>> +                       continue;
>> +
>> +               if (next->provider != prev->provider)
>> +                       continue;
>> +
>> +               provider = next->provider;
>> +               mutex_lock(&provider->lock);
>> +
>> +               /* aggregate requests for the provider */
> 
> Get rid of comment.

Ok.

>> +               provider_aggregate(provider, &avg_bw, &peak_bw);
>> +
>> +               if (provider->set) {
>> +                       /* set the constraints */
>> +                       ret = provider->set(prev, next, avg_bw, peak_bw);
>> +               }
>> +
>> +               mutex_unlock(&provider->lock);
>> +
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +/**
>> + * icc_set() - set constraints on an interconnect path between two endpoints
>> + * @path: reference to the path returned by icc_get()
>> + * @avg_bw: average bandwidth in kbps
>> + * @peak_bw: peak bandwidth in kbps
>> + *
>> + * This function is used by an interconnect consumer to express its own needs
>> + * in term of bandwidth and QoS for a previously requested path between two
>> + * endpoints. The requests are aggregated and each node is updated accordingly.
>> + *
>> + * Returns 0 on success, or an approproate error code otherwise.
> 
> *appropriate*

Ok.

[..]
>> +/**
>> + * struct icc_node - entity that is part of the interconnect topology
>> + *
>> + * @id: platform specific node id
>> + * @name: node name used in debugfs
>> + * @links: a list of targets where we can go next when traversing
>> + * @num_links: number of links to other interconnect nodes
>> + * @provider: points to the interconnect provider of this node
>> + * @node_list: list of interconnect nodes associated with @provider
>> + * @search_list: list used when walking the nodes graph
>> + * @reverse: pointer to previous node when walking the nodes graph
>> + * @is_traversed: flag that is used when walking the nodes graph
>> + * @req_list: a list of QoS constraint requests associated with this node
> 
> 
>> + * @avg_bw: aggregated value of average bandwidth
>> + * @peak_bw: aggregated value of peak bandwidth
> 
> Consider changing to "aggregated value of {average|peak} bandwidth
> requests from all consumers"

Ok, will clarify.

Thanks,
Georgi
