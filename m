Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751332AbeDEMeD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 08:34:03 -0400
Received: from mail-bn3nam01on0083.outbound.protection.outlook.com ([104.47.33.83]:61526
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751038AbeDEMeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 08:34:01 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH] drm/sched: Extend the documentation.
To: Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Alex Deucher <alexander.deucher@amd.com>
References: <20180404223251.28449-1-eric@anholt.net>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <4cb96513-9ec0-f4a8-01b3-7ab9a9d19ae8@amd.com>
Date: Thu, 5 Apr 2018 14:33:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180404223251.28449-1-eric@anholt.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: AM4PR0701CA0031.eurprd07.prod.outlook.com
 (2603:10a6:200:42::41) To DM5PR12MB1721.namprd12.prod.outlook.com
 (2603:10b6:3:10f::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 096ebf9a-98d6-47af-d4ca-08d59af18143
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1721;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1721;3:QIgKUuXY7KS4yVnPn+mZM+Gr7zsmPya3qo84XPAzANO8GynW3a9Zf5Lxv2BCtfDm19vNOi6eVWzSsGUJF+ft5Okm6wSAC8Fu1iGwPq6SByV/J2mcc5V4AnqoK8WZLr2cChW02NLUBgG5vw0wyKerp/5FOyqTjW9R8s0cn/hZA3WBuTvdHEIzNlwyfY9rbzuWW3cOD5xcJxqVecUMqgMossaAzl1GlScSpnW4a+iDfFyaV9B1ORSvUh4zhf/dZj8n;25:YlK6Z80U/0xf9T6tNObFCbiJtUjZE/eiRCh9c5iVkI01RlxopR8khnA/cX4pOdjrML7rYGo3RZeNjrFFmLB35CX4RduzW7ltONIgyggxo0W6SvIT7GmGasgm/4CTyPyu5EI0n7p4iwt+GegTa9nVGMsMnoB93FO0kL1ekwav2RjG0lIxbVwynoxNkl5dt6lrTx0Sq9ED/JaVvdlMJtxadIbAbf2Cny7Ee+3E1a5nhMjoHocRn+xSZMCUCsFa91/R3m+LwL8fFwV8d5PX+NSRt3UWoDbUB4Ty/g1Aoccyb5AKYwVYvokkY+KAsQLpD8ZtBAPbd7+5ulIMB7y9zoso/w==;31:fzYmUG+c3SYTWbA4ORJFaUqDRYvIYSXd5oV3kC7uki7n98Xi+4lS69JN2yXR87eysLLhwH88OgCR3HfUVFacJanbx4nBVibcHykFSiD0ubIRucZzKqioeRaJ+18jAUl6iSFlIzmRh9Nl7k/PhcNjXIgcEcyUTcPlCcXD/e8dDEYryPIckKpWKFGqsF3uawDBrOrNaYXGFpowkLOEv6xNhCdzj9zoIKdAXNBYwX9mHoY=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1721:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1721;20:NGheyIDrvI0Fq820ybkJprtsTxN8RKlOj18KmmcoiwpRQvRXuOsq+CQ4x+1iqZimzkQ6OxaXo6W4Viov9ZfywxKuSvnlvWIxSYQXl0PWBvkiyty7+h8D49Ocfeq1ILoReMDU5h/thjCIjL+Zv/Tq66Nu1mQpZe5BaRs9sz4k29YpvpSf7/PvJ4BksYsR48Iu7ODcwax9Ze5gV6AvhKpv+xCZyYL2QJSvKfbZMxwZ5KkkoD9XiF8djpa6UHiMQy8IrlsSTeL1X2DZHbq8s5iW464GEk1gQUKvog8HQAxrnbCEQmDodltJrehk6NI/XL9C3y+10BF5Qm6V+z53a40fkv8CBtm1iKVRJ3cK3Ps6gbFCc8YQKiE6nMeIscNSUAR2952XhDD8jE1in4NKcYZBa2pWdYVwEojJW32T5W1QwMtoPeJdm9GaSpONSD3HYKoYrQFPCbDfMecioyW7SUVNR7fkf4KUvEBxb0S2n6OEZL4LyzGIDL1Ultiy99Tiijqp;4:8F3pYlyjvROJFgFINuWk+M9BoD1zHe24izW4UlGj0ITutDfkRYFf1uMernweow8S0AgI38nZ1/S7zCBGLoMCnFNy24rwrQtH4m5/YoGvymZqJ2KQiCSoMu9G3TVGmSrCIBLIf999pcXDTeoYPndn+2wbo8tduL/ImU4nCpswWCBQeSkDs/Tjg4/fFrzX8/BhTrvNkz6rS1xeQFC92gawTndv5Ho4cvMBrzJBhOkXP3KQOXyqdPu1UBOY3xHWEpv0Y8mDQajcuM2sWi/v4TRFI+F+G6sHH8aksiFXhwsuZwE5KxTlgwyUG4cWaAWPR1KS
X-Microsoft-Antispam-PRVS: <DM5PR12MB17214C5A73534896DC8EA1FE83BB0@DM5PR12MB1721.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR12MB1721;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1721;
X-Forefront-PRVS: 06339BAE63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(39380400002)(396003)(366004)(376002)(189003)(199004)(50466002)(65806001)(97736004)(8676002)(8936002)(1706002)(6116002)(6246003)(54906003)(2870700001)(2906002)(478600001)(47776003)(486006)(46003)(81156014)(446003)(31696002)(11346002)(81166006)(106356001)(476003)(2616005)(58126008)(4326008)(65956001)(25786009)(86362001)(316002)(16526019)(52396003)(64126003)(52116002)(23676004)(52146003)(2486003)(72206003)(59450400001)(67846002)(386003)(76176011)(5890100001)(36756003)(6666003)(68736007)(305945005)(31686004)(7736002)(229853002)(105586002)(5660300001)(65826007)(6486002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1721;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNzIxOzIzOkUzZG1hRzlxTTJtYTIvUmxrYnhnNlp3SGpx?=
 =?utf-8?B?Y0FBTUQ0c3N6b1R0NTd1dDU2dXgyZHN5SlREaS93ZVp4Y3l4cU5yRmd4QzJz?=
 =?utf-8?B?djFpTzNVckxWUVhOTXd4Q3hTSlBleHBCbXJqcEdVQTJyWlM4YlFVejROdVpJ?=
 =?utf-8?B?Nm9EOTB5TWlxa3lDRnNhS3NDVVJsNEI4YlJVdTFMZkczdmp2SitHTXlIaUtC?=
 =?utf-8?B?VTRBY3MxbUJadzUwa0pnbG5LZXRBQktUNmlDdHB5bGlaWnhxRXdLaCtqRzc0?=
 =?utf-8?B?ZjloRkhzMnVCcGJsV2ZGSDZVdmlGYjZZaXVZL0VNWHVIejd4OUV0UVo1Zm1O?=
 =?utf-8?B?em1VcVQxQVBJakNpTFZ0b3NUZUlONHhrUXlzaXlKY0JDMlNTZlpraG5GdVZk?=
 =?utf-8?B?QzZWSDNNaDY3aWZvK1pnZ3pEOWxoM1lieXVHVmpMK0ZNQmtNY0FFYVAvRGV2?=
 =?utf-8?B?MjUwaXIyQ2xWVW9icm42anFzaW9jOUtEc1NHTzJudG5lZGs0T1JwS2tyVDZz?=
 =?utf-8?B?eHp3cXNVNlF4MXJnRVQ3MGZjMVlLZlMrLzdDejRBWUl0bk9VSSt3dE55WjJ2?=
 =?utf-8?B?dEx6dVBNY2x3NG9CYnU1L3M1TGRNZWc1Y054WXdPMGxMUlM3QWdTN1BYMVcy?=
 =?utf-8?B?blhOZDJ6TnNVSEtxUVVqQ1F3MWZNelBFVG1LWTlOL3JiaW4xSXFxcmFYeUcz?=
 =?utf-8?B?K3ZIdHlBTDdOQktDMU5FODM4ZXN5Q0U2c1ZoZHdFWWk5ZGxQbWhZbzFRMldG?=
 =?utf-8?B?eXR0Q0VyL0prZDBRNFRRQkQ5WDBPdTVPbStockE1YUs5cDNIZmNCMkNxUnRo?=
 =?utf-8?B?SDNCRmRnKytSR3prVzZQZ2hGU2hiQVl1eFVEQW8xeE10ZUdtVkszZU56SDJK?=
 =?utf-8?B?TFI2dThRajZaRVJWSmpxWkhPaDRHVGNLamVyYUxjaThHYzJEL1ZkTFNjek4v?=
 =?utf-8?B?ZVdONVZSWmNxYXZLaEtQclBIUTcwakxJUmhqV29LUU11eXFyK0FEd1NVNGh0?=
 =?utf-8?B?TndDc1Q1UTB2UTRoTi80STh1a3BPL2w2RUJ3dGN3VjFnL1hTRkZnM2lycGZN?=
 =?utf-8?B?ZE9WWlYzK21JNWZqZkFQZThrc21TZkxaR1R6b3lGQVVPbUw0bUtkb0xncnVX?=
 =?utf-8?B?OVBERll0U0RQWE5MVDdQd1FaUHNiSnZMRlByN3dEME5WVWdHck8vRTlLWExn?=
 =?utf-8?B?MHhxbVlxbjVWbFpTc3pXS2tzWUkrT3dYWUw1MnJ2UHRJY2w2Si9IZ1NXUllF?=
 =?utf-8?B?U01UWm9pSTFqaThQUkN0VVVwaEdHMXV0U1YvcDhMNkxvYi9vTUpib0pSNUlp?=
 =?utf-8?B?K2V0VzVHeHZwUTlnOHRhTUt4RHAwN1NBcTVPU2w3MFVIV21DLzErNTNPSzZV?=
 =?utf-8?B?UUsyN3JXZHhodEJWVzhFVkxXK1daZ3hrcGlUcjNaVDMyNWVaQ1NUcUdBMEJE?=
 =?utf-8?B?Sy9rczJVY1B5ajRnWElCZXhaK2Vtb01Ka3o1cWtHeDNxbFlWSVZoVk42eW9T?=
 =?utf-8?B?QUFpVW9QcUtlN1NqbTl3YUxRYWIxS0VSb1RrNVNYZHdHNnZpNWlsRjJqampa?=
 =?utf-8?B?MzZXK2NiZHFjTFh5bmdyTnFIR2JRREV4dU1lQ1NEcEdqMXZNNlBFcjA2NXVO?=
 =?utf-8?B?Q1U0eGMzWHZlZWNqN25JWGxyTDREVzcxUmJ2R25kRlhod3J3cmxtWjdMMmlm?=
 =?utf-8?B?cWluejFhY01jc05KRmtKVFc2eklMdEJLZzFyWE14QmxnQUNaTCtYR3gvQ2hT?=
 =?utf-8?B?RVJ5Y2NlWnptSzJBeGZ4Y1N3MStHM3NlbkxrREpxUFQxN3E4RXdKUUd2dTNE?=
 =?utf-8?B?LzlWVit4dU90ZmpNVnNFUmdFR25zdFRLem5EaUFiWUg2blBLWGFLNExtTFJt?=
 =?utf-8?Q?JyhFK1vsjSg9gryf0Q/WtBBen7E3tNJT?=
X-Microsoft-Antispam-Message-Info: lf0V7htRJB3RjorLMBkZLX3LCWrWhosTO3dWqaNQDer8TzLnUYJLAje58DksiPDHupL5kpXM8uA+wo2ILktttl2yZ6g3IYuX7wPYQPQ5L9WvMN6QLhg9cR/C6jMXdddcBH92M0A7CSVzd3tjsrApUMz2fuDlsINiTiA/qCVc3fX7Uj3BTUCTvpZK3VupP+L4
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1721;6:840xh2wOFd5I6Tr7j+clLw04QQCrriBNIzeVmMJL7DqZo+oyF8VmUf7eJcuvJxOGn56oa1sPiWONvX4Mx2eGLZugTQYzzeAtcJhP0WqSdvuvX7US67C5CskdVJnJlWMgjxpnQ4ptCFg/8MmQ/rCSDxCBPqtTKPk7uhwQ1V7K6Cm1XfKelrzdmocJkzFL1EGusN5Q+XERsWN5H9Qd8jubtrO8ws1jBbDLrVhfZX5rVKgsBUqTs1y/7jxaPRKINRwft5HGnba13orOV/CFOLi3JeE2he57AS2tJnDo//iOi0hTVc3qqW6gPa/PInsF2Y3fl0pFM2EdKzgqtk5V5XICsSog4cRk+dIWn0weXco0iED+rzRCNvs/3TYFBjICbgheEguRAXJd5U+5Lay+dcuJL8j5jfGuQCbAXfl+n2JqG5y1bzGWyWiDn6TzpKbL+93U7bhSII2eRgA2vdXCK5T0KA==;5:MeJWjhRFSQy0ReFKIMvXDney3PKth7F4mPK+UMhaAanCEyHqAsudTaMwCZNJabZx/s7deG/BQPqlvvDJ92XDrLsVSYaOgv0PssxZE0sc+IMAkQ10B0Oz+x2gY+a8HaNGY2bhgSGMVn79DApBlKRvER1Tg8Vcjik/v1A72KE9NuE=;24:a3z+gKvdP2LB0gnUsb3e5yLHPUHK20FvygBS2uhzfv/slwm0vYjQORWLN6BbqFQDG+QSaQcrIP4xTJU+E9znSSoVJMUzizcFbVOx8m8UbMA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1721;7:Myh8CuqUMa3P4/wQi2h8omt8AQS1s9qg8SnKqWPXX5mofMzOPCF7l4YNqRs8I5XjE38A5jyT9xDn2JHDgRAsMvW3gp0a2gtycGg1hh+SRj+a9hqu+HHiB3L2R+kL/BjVO7izwLLdTUQou4ODuZE1LFYkKluih+X2dPa77auiWqjR2UtKtefLsWLdiKSmqb+mxh1/Tdh83tlvNQfhSgM+GTf0T/Heg8ojCtWPe/vgs8Dk+dOrvan/tLo74r0TF6JX;20:Xz6jBDiUloF3/NxlOkHRX4rSwSELWosZIpm6AV5RdBpLq/5gmY490YnPd4cUH6M3S3CnpDnuHpmTa2UJ5KMdcmiU1kQWMe92fDZom8Q4k/5kMRFLKNbM9wmBouOpRcXbgJB7UWttFQTuHjjg2MSI6QyBFoaDlenenbloG/kd8oYuRlTOGXj7BU1skJ6tMnEL/AplG60QwgbZhouJDs+6M8BZvFTWPkKEGVFXTVpMxaboT9K+DQ+s9Y34AX5eZ9ib
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2018 12:33:57.9451 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 096ebf9a-98d6-47af-d4ca-08d59af18143
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1721
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 05.04.2018 um 00:32 schrieb Eric Anholt:
> These comments answer all the questions I had for myself when
> implementing a driver using the GPU scheduler.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>

Reviewed-by: Christian König <christian.koenig@amd.com>

Already pushed to amd-staging-drm-next as well.

Thanks,
Christian.

> ---
>   include/drm/gpu_scheduler.h | 46 +++++++++++++++++++++++++++++++++----
>   1 file changed, 42 insertions(+), 4 deletions(-)
>
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index dfd54fb94e10..c053a32341bf 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -43,10 +43,12 @@ enum drm_sched_priority {
>   };
>   
>   /**
> - * A scheduler entity is a wrapper around a job queue or a group
> - * of other entities. Entities take turns emitting jobs from their
> - * job queues to corresponding hardware ring based on scheduling
> - * policy.
> + * drm_sched_entity - A wrapper around a job queue (typically attached
> + * to the DRM file_priv).
> + *
> + * Entities will emit jobs in order to their corresponding hardware
> + * ring, and the scheduler will alternate between entities based on
> + * scheduling policy.
>   */
>   struct drm_sched_entity {
>   	struct list_head		list;
> @@ -78,7 +80,18 @@ struct drm_sched_rq {
>   
>   struct drm_sched_fence {
>   	struct dma_fence		scheduled;
> +
> +	/* This fence is what will be signaled by the scheduler when
> +	 * the job is completed.
> +	 *
> +	 * When setting up an out fence for the job, you should use
> +	 * this, since it's available immediately upon
> +	 * drm_sched_job_init(), and the fence returned by the driver
> +	 * from run_job() won't be created until the dependencies have
> +	 * resolved.
> +	 */
>   	struct dma_fence		finished;
> +
>   	struct dma_fence_cb		cb;
>   	struct dma_fence		*parent;
>   	struct drm_gpu_scheduler	*sched;
> @@ -88,6 +101,13 @@ struct drm_sched_fence {
>   
>   struct drm_sched_fence *to_drm_sched_fence(struct dma_fence *f);
>   
> +/**
> + * drm_sched_job - A job to be run by an entity.
> + *
> + * A job is created by the driver using drm_sched_job_init(), and
> + * should call drm_sched_entity_push_job() once it wants the scheduler
> + * to schedule the job.
> + */
>   struct drm_sched_job {
>   	struct spsc_node		queue_node;
>   	struct drm_gpu_scheduler	*sched;
> @@ -112,10 +132,28 @@ static inline bool drm_sched_invalidate_job(struct drm_sched_job *s_job,
>    * these functions should be implemented in driver side
>   */
>   struct drm_sched_backend_ops {
> +	/* Called when the scheduler is considering scheduling this
> +	 * job next, to get another struct dma_fence for this job to
> +	 * block on.  Once it returns NULL, run_job() may be called.
> +	 */
>   	struct dma_fence *(*dependency)(struct drm_sched_job *sched_job,
>   					struct drm_sched_entity *s_entity);
> +
> +	/* Called to execute the job once all of the dependencies have
> +	 * been resolved.  This may be called multiple times, if
> +	 * timedout_job() has happened and drm_sched_job_recovery()
> +	 * decides to try it again.
> +	 */
>   	struct dma_fence *(*run_job)(struct drm_sched_job *sched_job);
> +
> +	/* Called when a job has taken too long to execute, to trigger
> +	 * GPU recovery.
> +	 */
>   	void (*timedout_job)(struct drm_sched_job *sched_job);
> +
> +	/* Called once the job's finished fence has been signaled and
> +	 * it's time to clean it up.
> +	 */
>   	void (*free_job)(struct drm_sched_job *sched_job);
>   };
>   
